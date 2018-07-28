# uploadnewip  

##### Description  
uploadnewip is a way to dodge having to setup a static IP address for GNU/Linux devices.  
Utilising Dropbox as a middle man for storing IP addresses, uploadnewip uploads the IP address of (a) server(s) which it's installed on to as many dropbox accounts/folders as intended.  
(This is a companion program that pairs with [getnewip](https://github.com/BobyMCbobs/getnewip))  

##### Packaging
Debian:  
	Binary: `make deb-pkg`  
	Source: `make deb-src`  
CentOS/Fedora specs: support/specs/CentOS-Fedora  
openSUSE specs: support/specs/openSUSE  
Arch Linux: [AUR](https://aur.archlinux.org/packages/uploadnewip)  
Zip archive: `make build-zip`  

##### Dependencies  
curl bash  

##### Installation
Non-package installation: `make install`  

##### Usage
Standard use: `uploadnewip [ARGS]`   
Help: `uploadnewip -h`  
Generate a config unit: `uploadnewip -m`  

##### Features  
- Config unit architecture. Have multiple config entries changing at once.  
- Small footprint; Lightweight.  
- Change multiple user SSH config entries.  
- Well configurable.  

##### Dropbox app  
1. Go to the [Dropbox app](https://www.dropbox.com/developers/apps) page.  
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name.  
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey'.  

##### Notes
- This has been testing on GNU/Linux distributions: Arch Linux, CentOS (7), Debian (9.x), Fedora (28), openSUSE (Leap 15, Tumbleweed), Raspbian (9.x), and Ubuntu (16.04, 18.04).  
- Currently only supports Systemd, no plans currently otherwise.  
- Main repository is on [GitLab](https://gitlab.com/BobyMCbobs/uploadnewip). There is a [GitHub](https://github.com/BobyMCbobs/uploadnewip) mirror.
