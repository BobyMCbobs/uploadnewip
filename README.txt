Welcome to uploadnewip by BobyMCbobs

This program is the server side version for uploading your external IP to Dropbox.
This program works well when paired with getnewip (for client side).

This has been tested on Linux (Raspbian, Ubuntu), unsure about FreeBSD or MacOS support.

-- Installing --

  Run './install.sh' (or 'bash install.sh') and follow the instructions. -- You'll need to setup the configuration, however. Edit uploadnewip.config.

  -- Configurations --

    A config file should look something like:

      #!/bin/bash

      ##CONFIG FILE OF install.sh FOR uploadnewip

      #folder where programs of this will be stored.
      scriptsFolder="$HOME/.scripts"
      #nickname/purpose for IP. DO NOT HAVE SPACES.
      purpose_name="home"
      #server to test internet connectivity. 8.8.8.8 is good cause it will always be up.
      ping_server="8.8.8.8"
      #folder in dropbox where IP is stored.
      dropbox_folder="IP"
      #amount of seconds to wait for loop periods.
      loop_seconds="30"
      #install systemd service ## y | n
      systemd_service_install="y"
      #dropbox authentication key
      dropbox_key="NUeL78eR11gAAAAAAAAADLeOE1DqkOk8ainvY9Ff5sjhcIwDEL46be2JH05Tb-ER"

    The Dropbox key is required for uploading to Dropbox.
    You must create a Dropbox app over at https://www.dropbox.com/developers/apps, then click generate OAuth2 access token. Use this token/key in your config.

-- Removing --

  Run './install -r'. You'll get an option to remove via config, or input your custom removal variables.
  This will:
   - Stop and Disable the Systemd service.
   - Remove
     - The systemd service
     - uploadnewip inside of said scripts folder.

Enjoy.
