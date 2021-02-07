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

# Separate debugging symbols
${OBJCOPY} --only-keep-debug ${PREFIX}/lib/libtango.so.${PKG_VERSION} ${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg
chmod 664 ${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg
${OBJCOPY} --strip-debug ${PREFIX}/lib/libtango.so.${PKG_VERSION}
${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/libtango.so.${PKG_VERSION}.dbg ${PREFIX}/lib/libtango.so.${PKG_VERSION}
