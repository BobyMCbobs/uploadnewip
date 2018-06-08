# uploadnewip  

##### Description  
uploadnewip is a way to dodge having to setup an static IP address for a GNU/Linux server or device.  
Utilising Dropbox as a middle man for storing IP addresses, uploadnewip uploads the IP address of (a) server(s) which it's installed on to as many dropbox accounts/folders as intended.  
(This is a companion program that pairs with [getnewip](https://github.com/BobyMCbobs/getnewip))  

##### Building
Debian based: `make deb` (Dependencies: fakeroot)  
Arch based:  
1. cd into './support/arch'  
2. `makepkg`  

##### Installation
Standard installation: `make install`  
Arch: `makepkg -si` (when inside './support/arch')  

##### Usage
Standard use: `uploadnewip [ARGS]`   
Help: `uploadnewip -h`  
Generate a config unit: `uploadnewip -m`  

##### Dropbox app  
1. Go to [Dropbox app](https://www.dropbox.com/developers/apps) page  
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name  
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey'.  
