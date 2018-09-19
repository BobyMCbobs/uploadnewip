# uploadnewip  

#### Release version: 2.2.1

##### Description  
uploadnewip is a way to dodge having to setup a static IP address for GNU/Linux devices.  
Utilising Dropbox as a middle man for storing IP addresses, uploadnewip uploads the IP address of (a) server(s) which it's installed on to as many dropbox accounts/folders as intended.  
(This is a companion program that pairs with [getnewip](https://github.com/BobyMCbobs/getnewip))  

##### Where to get it
Ubuntu: ppa:bobymcbobs/ppa  
openSUSE, SUSE, Fedora, ScientificLinux, RHEL, CentOS: [OBS](https://software.opensuse.org/package/uploadnewip)  
Arch Linux: [AUR](https://aur.archlinux.org/packages/uploadnewip)  

##### Features  
- Config unit architecture. Have multiple config entries changing at once.  
- Small footprint; Lightweight.  
- Change multiple user SSH config entries.  
- Well configurable.  

##### Packaging
Debian:  
	Binary: `make deb-pkg`  
	Source: `make deb-src`  
CentOS/Fedora specs: support/specs/CentOS-Fedora  
openSUSE specs: support/specs/openSUSE  
Arch Linux: support/arch/PKGBUILD  
Zip archive: `make build-zip`  

##### Installation
Non-package installation: `make install`  
Options:  
	Disabling systemd service installation: `make NOSYSTEMD=true install`  

##### Dependencies  
Ubuntu/Debian/Raspbian: curl bash nano iputils-ping  
Arch Linux: curl bash nano iputils  
Fedora/CentOS: curl bash nano iputils  
openSUSE: curl bash nano iputils  

##### Usage
Standard use: `uploadnewip [ARGS]`   
Help: `uploadnewip -h`  
Generate a config unit: `uploadnewip -m`  

##### Dropbox app  
1. Go to the [Dropbox app](https://www.dropbox.com/developers/apps) page.  
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name.  
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey'.  

##### Notes
- This has been testing on GNU/Linux distributions: Arch Linux, CentOS (7), Debian (9.x), Fedora (28), openSUSE (Leap 15, Tumbleweed), Raspbian (9.x), and Ubuntu (16.04, 18.04).  
- Currently only supports Systemd, no plans currently otherwise.  
- Building a debian package requires 'build-essential' and 'devscripts'.
- Main repository is on [GitLab](https://gitlab.com/BobyMCbobs/uploadnewip). There is a [GitHub](https://github.com/BobyMCbobs/uploadnewip) mirror.
