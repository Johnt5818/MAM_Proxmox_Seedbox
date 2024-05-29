#!/usr/bin/env bash
############################################################################################################
# Created by John Thompson 5/29/2024
# Note: I am not a programmer and do this as a self-taught hobby. 
# Please let me know if I have made a mistake or if there would be a better way to do something.
# 
# To Do:
# 1. Look at https://helper-scripts.com/ and see what is needed to get a basic Debian 12 conatiner installed
# 2. Figure out Specific order of installation for Qbittorent, Readarr, Prowlarr, PIA VPN, & MAM_ID.
#    - Get Qbittorent setup done (just apt install qbittorrent-nox?)
#    - Get Readar/Prowlarr setup done (using Servarr?)
#    - Get PIA VPN setup done
#    - Get MAM_ID setup done
# 3. Validate that everything works from this install script
############################################################################################################

#install Debian LXC. this needs to be run on theProxmox VE Shell. 
# Questions: should this be aprt of this script? or should it be a seperate command. is so, how to I run the other items? 
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/debian.sh)"

#install required apps 
#? apt update
#? apt full-upgrade
apt install qbittorrent-nox
apt install wireguard
apt install jq

