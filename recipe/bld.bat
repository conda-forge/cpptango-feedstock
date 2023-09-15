setlocal EnableDelayedExpansion

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DBUILD_TESTING=OFF ^
      -DTANGO_INSTALL_DEPENDENCIES=OFF ^
      -DCMAKE_CXX_FLAGS_RELEASE="/MD" ^
      -DCMAKE_CXX_FLAGS_DEBUG="/MDd" ^
      ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit

nmake install
if errorlevel 1 exit
