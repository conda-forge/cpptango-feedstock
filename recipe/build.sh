if [[ "$host_alias" != "$build_alias" ]]
then
  TANGO_OMNIIDL_PATH="${BUILD_PREFIX}/bin"
else
  TANGO_OMNIIDL_PATH="${PREFIX}/bin"
fi

mkdir build
cd build
cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DTANGO_USE_TELEMETRY=ON \
      -DBUILD_TESTING=OFF \
      ..

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
