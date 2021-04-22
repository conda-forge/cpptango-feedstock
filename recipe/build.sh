mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCPPZMQ_BASE=$PREFIX \
      -DIDL_BASE=$PREFIX \
      -DOMNI_BASE=$PREFIX \
      -DZMQ_BASE=$PREFIX \
      -DTANGO_JPEG_MMX=OFF \
      -DBUILD_TESTING=OFF \
      ..

make -j $CPU_COUNT
make install

# LIBVERSION=${PKG_VERSION}
LIBVERSION=9.3.5

# Separate debugging symbols
${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libtango.so.${LIBVERSION} ${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg
chmod 664 ${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg
${OBJCOPY} --strip-debug ${PREFIX}/lib/libtango.so.${LIBVERSION}
${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libtango.so.${LIBVERSION}.dbg ${PREFIX}/lib/libtango.so.${LIBVERSION}
