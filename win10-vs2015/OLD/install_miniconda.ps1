
$mc_exe = "Miniconda3-4.6.14-Windows-x86_64.exe"
$mc_url = "https://repo.continuum.io/miniconda/$mc_exe"

#echo $mc_url
#echo $mc_exe

$my_mc = "c:\\$mc_exe"

# Download Miniconda installer
if (! (Test-Path $my_mc) )
  {
  echo "Downloading $mc_url"
  Invoke-WebRequest -Outfile $my_mc -Uri $mc_url
  }
else
  {
  echo "$my_mc already downloaded"
  }


# Run the downloaded installer
$cmd = "$my_mc /S"
echo "Running install command: $cmd"
Invoke-Expression $cmd



