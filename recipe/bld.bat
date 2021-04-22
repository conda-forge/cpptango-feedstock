setlocal EnableDelayedExpansion

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCPPZMQ_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DIDL_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DOMNI_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DZMQ_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DPTHREAD_WIN:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_JPEG_MMX=OFF ^
      -DBUILD_TESTING=OFF ^
      -DTANGO_INSTALL_DEPENDENCIES=OFF ^
      -DCMAKE_CXX_FLAGS_RELEASE="/MT" ^
      -DCMAKE_CXX_FLAGS_DEBUG="/MTd" ^
      ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit

nmake install
if errorlevel 1 exit
