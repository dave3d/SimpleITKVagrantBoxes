# SimpleITKVagrantBoxes
Vagrant boxes to set up virtual machines to build SimpleITK

The provisioning section of the Vagrantfile upgrades [chocolatey](https://chocolatey.org) and then installs cmake, git, miniconda and Visual Studio 14 (2015).

On a new box, sometimes the VS14 install fails.  It takes a long time, downloading stuff from Microsoft, and I think it times out some times.  In that case, you need to go into  Powershell and 'choco install visualstudio2015community' by hand.

The vagrant box that this is based off of, (jacqinthebox/windowsserver2016)[https://app.vagrantup.com/jacqinthebox/boxes/windowsserver2016], has boxes for Virtual Box, VMWare, and Parallels.
