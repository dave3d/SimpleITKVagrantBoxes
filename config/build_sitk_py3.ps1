

# Command line options
param (
  $bit = 64,
  $version = 37
)

$python_versions = 35, 36, 37

echo $bit
if ($bit -ne 32 -and $bit -ne 64) {
  $bit = 64
}
echo $bit
$generator = 'Visual Studio 14 2015 Win64'
if ($bit -eq 32) {
  $generator = 'Visual Studio 14 2015'
}

if ( ! $python_versions.Contains($version) ) {
  # get the last one on the version list
  $version = $python_versions[$python_versions.Length-1]
}


if (Test-Path 'C:\SimpleITK') {
  # If there's a SimpleITK, move it to SimpleITK.old.  Note, if there's
  # a SimpleITK.old, it gets overwritten.
  Rename-Item 'C:\SimpleITK' 'C:\SimpleITK.old' -force
}

cd c:\
git clone https://github.com/SimpleITK/SimpleITK.git

$myid = "py$version"

$build_dir = "C:\sitk-$myid"

rm $build_dir -r -fo

mkdir $build_dir

# Configure the build
#
$config_params =  '-G', $generator, '-C', 'c:\config\sitk_windows.cmake', '-S', 'C:\SimpleITK\Superbuild', '-B', $build_dir
$cmake = 'C:\Program Files\CMake\bin\cmake.exe'

& $cmake $config_params


# Build SimpleITK
#
$build_params = '--build', $build_dir, '--config', 'Release'
& $cmake $build_params
