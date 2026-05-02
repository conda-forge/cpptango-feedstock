if [[ "$host_alias" != "$build_alias" ]]
then
  TANGO_OMNIIDL_PATH="${BUILD_PREFIX}/bin"
else
  TANGO_OMNIIDL_PATH="${PREFIX}/bin"
fi

cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DTANGO_USE_TELEMETRY=ON \
      -DBUILD_TESTING=OFF \
      -S . \
      -B build

cmake --build build
cmake --install build

# Separate debugging symbols on Linux
if [ ! -z "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION} ${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION}.dbg
  chmod 664 ${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION}.dbg ${PREFIX}/lib/libtango.so.${CPPTANGO_VERSION}
fi
