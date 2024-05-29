#!/usr/bin/env bash
############################################################################################################
# Created by John Thompson 5/29/2024
# Note: I am not a programmer and do this as a self-taught hobby. Please let me know if I have made a mistake or if there would be a better way to do something.
# Parts were taken from several forum posts that helped me figure it out and set it up. 
# Thanks for those posts:
# https://www.myanonamouse.net/f/t/68388/p/p761169#761169
# https://www.myanonamouse.net/api/endpoint.php/3/json/dynamicSeedbox.php
# https://www.myanonamouse.net/f/t/62162/p/1
# https://www.myanonamouse.net/f/t/63782/p/p697018#697018
############################################################################################################

# Only allow the script to run as root
if (( EUID != 0 )); then
  echo -e "${red}This script needs to be run as root. Try again with 'sudo $0'${nc}"
  exit 1
fi

#installs curl and python3 if needed.
apt add curl && apt add python3

#check/create root/mam folder
if [ ! -d "$DIRECTORY" ]; then
  mkdir /root/mam
fi


# Erase previous mam.cookies if present
rm -f /root/mam/mam.cookies

#check if MAM_ID is set
FILE=/root/mam/mam_id.txt 
if [ -f "$FILE" ]; then
  echo "looks like you already have a mam_id.txt file set up. if there are problems, you could check the /root/mam/mam_id.txt file and make sure the correct MAM_ID is there"
else
  echo -n "No MAM_ID was found in ./mam_id.txt. Please add it now: "
  read -r -s MAM_ID
  touch /root/mam/mam_id.txt
  echo $MAM_ID >| /root/mam/mam_id.txt
fi

#Run command to 
curl -c root/mam/mam.cookie -b 'mam_id=${MAM_ID}' https://t.myanonamouse.net/json/dynamicSeedbox.php | python3 -c \"import sys,json; sys.exit(not json.load(sys.stdin)['Success'])\"

#create's reoconnect systemcmd files and enables them if it has not already been done
FILE=/etc/systemd/system/mam-seedbox.service
if [ -f "$FILE" ]; then
    echo "$FILE exists. if you are having problems, check the status by issueing: systemctl status mam-seedbox.service"
else
    echo "$FILE dose not exist. Creating the file now"
    wget -P /etc/systemd/system/ https://raw.githubusercontent.com/Johnt5818/MAM_Proxmox_Seedbox/main/systemd_files/mam-seedbox.service
    systemctl daemon-reload
    systemctl enable mam-seedbox.service
fi

FILE=/etc/systemd/system/mam-seedbox.timer
if [ -f "$FILE" ]; then
    echo "$FILE exists. if you are having problems, check the status by issueing: systemctl list-timers"
else
    echo "$FILE dose not exist. Creating the file now"
    wget -P /etc/systemd/system/ https://raw.githubusercontent.com/Johnt5818/MAM_Proxmox_Seedbox/main/systemd_files/mam-seedbox.timer
    systemctl daemon-reload
    systemctl enable --now mam-seedbox.timer
    systemctl list-timers
fi


#setup should be done at this point
echo Setup compleate.