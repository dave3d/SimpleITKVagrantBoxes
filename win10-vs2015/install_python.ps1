
param (
  $bit = 64,
  $version = 37
)

$python_versions = 27, 35, 36, 37

echo $bit
if ($bit -ne 32 -and $bit -ne 64) {
  $bit = 64
}
echo $bit

if ($version -eq 2) {
  $version = 27
} elseif ( ($version -eq 3) -or (! $python_versions.Contains($version)) ) {
  $version = $python_versions[$python_versions.Length-1]
}



#echo $bit
#echo $version
$pyversion = "$version-$bit"
echo $pyversion


# Table of links to the various Python downloadable installers
[hashtable]$py_links = @{
  "27-64" = "https://www.python.org/ftp/python/2.7.16/python-2.7.16.amd64.msi";
  "27-32" = "https://www.python.org/ftp/python/2.7.16/python-2.7.16.msi";

  "35-64" = "https://www.python.org/ftp/python/3.5.4/python-3.5.4-amd64.exe";
  "35-32" = "https://www.python.org/ftp/python/3.5.4/python-3.5.4.exe";

  "36-64" = "https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe";
  "36-32" = "https://www.python.org/ftp/python/3.6.8/python-3.6.8.exe";

  "37-64" = "https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe";
  "37-32" = "https://www.python.org/ftp/python/3.7.3/python-3.7.3.exe";
}

$py_url = $py_links[$pyversion]

$words = $py_url.Split('/')

$len = $words.Length

$py_name = $words[$len-1]

$py_exe = "C:\$py_name"

echo $py_url
echo $py_exe

# Download Python installer. Check if it's already here.
if (! (Test-Path $py_exe) )
  {
  echo "Downloading $py_exe"
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Invoke-WebRequest -Outfile $py_exe -Uri $py_url
  }
else
  {
  echo "$py_exe already downloaded"
  }

# Run the downloaded Python installer
$cmd = "$py_exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 Include_pip=1"
echo "Running install command: $cmd"
Invoke-Expression $cmd


if ($version -eq 27) {
  $install_dir = "C:\Python27"
} else {
  if ($bit -eq 32) {
    $install_dir = "C:\Program Files (x86)\Python$version"
  } else {
    $install_dir = "C:\Program Files\Python$version"
  }
}

$pip = "$install_dir\Scripts\pip.exe"
echo $pip
