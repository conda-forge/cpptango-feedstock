setlocal EnableDelayedExpansion

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_CPPZMQ_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_IDL_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_OMNI_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_ZMQ_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_JPEG_BASE:PATH="%LIBRARY_PREFIX%" ^
      -DPTHREAD_WIN:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_USE_PCH=OFF ^
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
