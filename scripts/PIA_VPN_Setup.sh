#!/usr/bin/env bash
############################################################################################################
# Created by John Thompson 5/29/2024
# Note: I am not a programmer and do this as a self-taught hobby. 
# Please let me know if I have made a mistake or if there would be a better way to do something.
############################################################################################################

# Only allow the script to run as root
if (( EUID != 0 )); then
  echo -e "${red}This script needs to be run as root. Try again with 'sudo $0'${nc}"
  exit 1
fi

#install required applications.
apt install wireguard
apt install jq
apt install unzip

#create directorie
mkdir /root/manual-connection-master
cd /root

#download PIA connection master tools
wget https://github.com/pia-foss/manual-connections/archive/refs/heads/master.zip
unzip master.zip
cd manual-connections-master/

#mod run_setup.sh so that it will also update Qbittorrent's port.
