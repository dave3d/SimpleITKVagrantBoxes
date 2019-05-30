
$pyversion = 3.7
#
if (Test-Path 'C:\SimpleITK') {
  # If there's a SimpleITK, move it to SimpleITK.old.  Note, if there's
  # a SimpleITK.old, it gets overwritten.
  Rename-Item 'C:\SimpleITK' 'C:\SimpleITK.old' -force
}
cd c:\
git clone https://github.com/SimpleITK/SimpleITK.git

$build_dir = "C:\sitk-$pyversion"

rm $build_dir -r -fo

mkdir $build_dir

$conda_dir = 'C:\ProgramData\Miniconda3'
$conda = "$conda_dir\Scripts\conda.exe"
$conda_params =  'create', '-y', '-n', "py$pyversion", "python=$pyversion"

& $conda $conda_params
