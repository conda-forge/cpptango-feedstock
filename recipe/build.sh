if [[ "$host_alias" != "$build_alias" ]]
then
  # We cannot use try_run when cross compiling, so we just say running the
  # binary succeeded
  ADDITIONAL_ARGS="-DOMNIIDL_TEST_RUN=0"
else
  ADDITIONAL_ARGS=""
fi

mkdir build
cd build
cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DTANGO_CPPZMQ_BASE="$PREFIX" \
      -DTANGO_IDL_BASE="$PREFIX" \
      -DTANGO_OMNI_BASE="$PREFIX" \
      -DTANGO_ZMQ_BASE="$PREFIX" \
      -DTANGO_JPEG_BASE="$PREFIX" \
      -DBUILD_TESTING=OFF \
      ${ADDITIONAL_ARGS} ..

make -j $CPU_COUNT
make install

# Separate debugging symbols on Linux
if [ ! -z "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libtango.so.${PKG_VERSION} ${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg
  chmod 664 ${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libtango.so.${PKG_VERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg ${PREFIX}/lib/libtango.so.${PKG_VERSION}
fi
