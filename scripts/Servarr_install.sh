#!/usr/bin/env bash
############################################################################################################
# Created by John Thompson 5/29/2024
# Note: I am not a programmer and do this as a self-taught hobby. 
# Please let me know if I have made a mistake or if there would be a better way to do something.
# 
# To Do:
# 1. see if aguments can be passed into the script to preselect what and how things get installed.
#    - Alternatly, is there other scripts that would be better to specificly install Prowlarr/Readarr?
# 2. Write out instructions on what exactly needs to happen to get Prowllar and Readarr installed.
############################################################################################################
curl -o servarr-install-script.sh https://raw.githubusercontent.com/Servarr/Wiki/master/servarr/servarr-install-script.sh
sudo bash servarr-install-script.sh 