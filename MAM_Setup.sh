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
apk add curl && apk add python3

# Erase previous mam.cookies if present
rm -f ./mam.cookies

#check if MAM_ID is set
MAM_ID = $(< ./mam_id.)
if $MAM_ID = ""; then
  echo -n "No MAM_ID was found in ./mam_id.txt. Please add it now: "
  read -r -s MAM_ID
fi

#Run command to 
curl -c /mam.cookie -b 'mam_id=${MAM_ID}' https://t.myanonamouse.net/json/dynamicSeedbox.php | python3 -c \"import sys,json; sys.exit(not json.load(sys.stdin)['Success'])\"
