mkdir build
cd build
cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DCPPZMQ_BASE="$PREFIX" \
      -DIDL_BASE="$PREFIX" \
      -DOMNI_BASE="$PREFIX" \
      -DZMQ_BASE="$PREFIX" \
      -DTANGO_JPEG_MMX=OFF \
      -DBUILD_TESTING=OFF \
      ..

make -j $CPU_COUNT
make install

# LIBVERSION can't be set to PKG_VERSION for dev and rc releases
# LIBVERSION=${PKG_VERSION}
LIBVERSION=9.3.6

# Separate debugging symbols on Linux
if [ ! -z "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libtango.so.${LIBVERSION} ${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg
  chmod 664 ${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/lib/libtango.so.${LIBVERSION}
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg ${PREFIX}/lib/libtango.so.${LIBVERSION}
fi
