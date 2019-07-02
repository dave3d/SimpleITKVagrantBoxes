
#
# A Powershell script to download and install CMake
#

$cmakeDir = "C:\CMake"

if (-not (Test-Path $cmakeDir))
{
  New-Item -ItemType Directory -Force -Path $cmakeDir
  $cmakeZipPath = "$cmakeDir\cmake.zip"

  # Use newest TLS1.2 protocol version for HTTPS connections
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

  # Download the CMake zip file
  Invoke-WebRequest -OutFile $cmakeZipPath -Uri https://github.com/Kitware/CMake/releases/download/v3.14.3/cmake-3.14.3-win64-x64.zip

  # Unpack the zip
  Expand-Archive -Path $cmakeZipPath -DestinationPath $cmakeDir


  # Move the sub-dirs up
  $cmakeUnzipDir = Get-ChildItem -Path "$cmakeDir\cmake-*" -Directory

  foreach ($dir in "bin","doc","man","share") {
    Move-Item -Path "$cmakeUnzipDir\$dir" -Destination $cmakeDir
  }

  # Clean up
  Remove-Item $cmakeZipPath
  Remove-Item $cmakeUnzipDir

}
else
{
  Write-Host "CMake is already installed, bro."
}

