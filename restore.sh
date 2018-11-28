#!/bin/bash
################################################################################
# 
#      ____  _____ ____ _____ ___  ____  _____ 
#     |  _ \| ____/ ___|_   _/ _ \|  _ \| ____|
#     | |_) |  _| \___ \ | || | | | |_) |  _|  
#     |  _ <| |___ ___) || || |_| |  _ <| |___ 
#     |_| \_\_____|____/ |_| \___/|_| \_\_____|
#                                         
################################################################################
# restore app sources
cp sources.list /etc/apt
cp -r sources.list.d /etc/apt

# restore apt
sudo apt-get update && sudo apt-get upgrade
sudo dpkg --clear-selections
sudo dpkg --set-selections < package_list
sudo apt-get update && sudo apt-get dselect-upgrade
sudo apt autoremove

# restore pip
pip install -r pip_modules.txt

# restore configs
cp -r ./config/* /home/$USER
