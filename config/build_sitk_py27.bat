

REM This script needs to be executed in a Visual C++ command prompt.
REM The bitness (32 or 64) of the build will depend on the bitness of
REM command prompt window.
call "C:\Program Files (x86)\Common Files\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" x86

SET sourcedir=C:\SimpleITK
SET builddir=C:\sitk-py27

IF NOT EXIST %sourcedir% (
   echo "Cloning source..."
   git clone https://github.com/SimpleITK/SimpleITK.git %sourcedir%
) ELSE (
  echo "Fetching source..."
  pushd %sourcedir%
  git fetch
  popd
)

pushd %sourcedir%
git checkout origin/release
popd



IF EXIST %builddir% (
  rmdir /S /Q %builddir%
) else (
  mkdir %builddir%
)


set CXXFLAGS=/MP
set CFLAGS=/MP


"C:\Program Files\CMake\bin\cmake.exe" -D PYTHON_EXECUTABLE="C:/Python27-32/python.exe" -G "Ninja" -C "C:\config\sitk_windows.cmake" -S "C:\SimpleITK\Superbuild" -B %builddir%

"C:\Program Files\CMake\bin\cmake.exe" --build %builddir% --config Release
