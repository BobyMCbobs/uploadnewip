#!/bin/bash

#
# install.sh for uploadnewip by github.com/Boby_MC_bobs
# Licensed under GPL3, have fun.
#

# v1

echo "-- Welcome to install for uploadnewip. --

(Please make sure you have read README.txt)
"

. uploadnewip.config

first_arg="$1"

if [ "$first_arg" = "-r" ]
then
	echo "> Starting removal of uploadnewip."

	echo "Use variables from uploadnewip.config? [y|n]"
	read use_vars

	if [ $use_vars = "n" ]
	then
		echo "Please enter purpose/nickname of setup: (i.e: home, work... etc.)"
		read purpose_name

		echo "Where is the scripts folder? (i.e: $HOME/.scripts/, $HOME/bin)"
		read scriptsFolder

		echo "Have you installed a Systemd service? [y|n] "
		read systemd_service_install
	fi

	echo "Are these variables all correct?

	- Nickname/purpose is '$purpose_name'.
	- Scripts folder is '$scriptsFolder'.
	- Look for Systemd service is '$systemd_service_install'.

If any of these variables are empty please look back over on uploadnewip.config.
Continue? [y|n]
	"
	read continue_var

	if [ $continue_var = "n" ]
	then
		exit
	fi

	if [ ! $systemd_service_install = "n" ]
	then
		echo "> Checking. Systemd service included."
		if [ -f /etc/systemd/system/uploadnewip-$purpose_name.service ] && [ -f $scriptsFolder/uploadnewip/uploadnewip-$purpose_name ]
		then
			echo "> Cleaning up files. Removing '$scriptsFolder/uploadnewip'"
			sudo systemctl stop uploadnewip-$purpose_name.service
			sudo systemctl disable uploadnewip-$purpose_name.service
			sudo rm /etc/systemd/system/uploadnewip-$purpose_name.service
			rm -r $scriptsFolder/uploadnewip
		else
			echo "> Cannot find files."
			exit
		fi
	else
		echo "> Checking. Systemd service not included."
		if [ -f $scriptsFolder/uploadnewip/uploadnewip-$purpose_name ]
		then
			echo "> Cleaning up files. Removing folder '$scriptsFolder/uploadnewip'"
			rm -r $scriptsFolder/uploadnewip
		else
			echo "> Can't find files."
			exit
		fi
	fi
	echo "> Complete."
	exit
fi

function make_systemd_service() {
#make systemd service
  cat > uploadnewip-$purpose_name.service << EOL
[Unit]
Description=Simple program to check if external IP has changed, then uploading it to DropBox, if so.
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$scriptsFolder
ExecStart=$scriptsFolder/uploadnewip/uploadnewip-$purpose_name
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
}

function edit_prog() {
#change program configs
  echo "Is this the correct config?

  - Scripts folder is '$scriptsFolder'.
  - Purpose is '$purpose_name'.
  - Ping server is '$ping_server'.
  - Dropbox folder is '$dropbox_folder'.
  - Loop time in seconds is '$loop_seconds'.
  - Systemd service is '$systemd_service_install'.
  - Dropbox authentication key is '$dropbox_key'.

Make sure there are no empty entries. Edit uploadnewip.config.
Continue? [y|n]"
  read continue_var

  if [ ! $continue_var = "y" ]
  then
    exit
  fi


  if cp uploadnewip uploadnewip-$purpose_name-temp
	then
		echo "> Made temp file to edit."
	fi

  sed -i -e "s/purpose_name=''/purpose_name='$purpose_name'/g" uploadnewip-$purpose_name-temp
  sed -i -e "s/dbFolder=''/dbFolder='$dropbox_folder'/g" uploadnewip-$purpose_name-temp
  sed -i -e "s/loopDelayTime=''/loopDelayTime='$loop_seconds'/g" uploadnewip-$purpose_name-temp
  sed -i -e "s/ping_server=''/ping_server='$ping_server'/g" uploadnewip-$purpose_name-temp
  sed -i -e "s#scriptsFolder=''#scriptsFolder='$scriptsFolder'#g" uploadnewip-$purpose_name-temp
}

function set_in_place() {
#enable + start service
  if [ ! -d "$scriptsFolder/uploadnewip" ]
  then
    echo "> '$scriptsFolder/uploadnewip' doesn't exist... creating it now."
    mkdir -p $scriptsFolder/uploadnewip
  fi

  holding_folder="$scriptsFolder/uploadnewip"

  echo "> Setting in place."
  if cp uploadnewip-$purpose_name-temp $holding_folder/uploadnewip-$purpose_name && chmod +x $holding_folder/uploadnewip-$purpose_name
	then
		if [ ! $systemd_service_install = "n" ]
		then
	    if sudo cp uploadnewip-$purpose_name.service /etc/systemd/system && \
	    sudo systemctl enable uploadnewip-$purpose_name.service && \
	    sudo systemctl start uploadnewip-$purpose_name.service
			then
				echo "> Service enabled and started."
			fi
		fi
		if echo "OAUTH_ACCESS_TOKEN=$dropbox_key" > $HOME/.dropbox_uploader
		then
			echo "> DropBox Uploader config made."
		fi
    echo "> Installed."
    if rm uploadnewip-$purpose_name-temp uploadnewip-$purpose_name.service
		then
			echo "> Removed temp files."
		fi
  fi

	echo "> Setup Complete."
}

edit_prog
make_systemd_service
set_in_place
