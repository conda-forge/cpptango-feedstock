setlocal EnableDelayedExpansion

cmake -G Ninja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DBUILD_TESTING=OFF ^
      -DTANGO_USE_TELEMETRY=OFF ^
      -DTANGO_INSTALL_DEPENDENCIES=OFF ^
      -DCMAKE_CXX_FLAGS_RELEASE="/MD" ^
      -DCMAKE_CXX_FLAGS_DEBUG="/MDd" ^
      -S . ^
      -B build
if errorlevel 1 exit 1

cmake --build build
if errorlevel 1 exit

cmake --install build
if errorlevel 1 exit
