

IF EXIST "C:\SimpleITK" (
  rename C:\SimpleITK C:\SimpleITK.old
)

cd c:\

git clone https://github.com/SimpleITK/SimpleITK.git

SET builddir=C:\sitk-py27

IF EXIST %builddir% (
  del /Q %builddir%
) else (
  mkdir %builddir%
)

"C:\Program Files\CMake\bin\cmake.exe" -G "NMake Makefiles" -C "C:\config\sitk_windows.cmake" -S "C:\SimpleITK\Superbuild" -B %builddir%

"C:\Program Files\CMake\bin\cmake.exe" --build %builddir% --config Release
