#!/bin/bash
################################################################################
#
#     ____    _    ____ _  ___   _ ____  
#    | __ )  / \  / ___| |/ / | | |  _ \ 
#    |  _ \ / _ \| |   | ' /| | | | |_) |
#    | |_) / ___ \ |___| . \| |_| |  __/ 
#    |____/_/   \_\____|_|\_\\___/|_|    
#                                    
#    This script gets lists of installed programs from apt, snap, and pip, and 
#    and stores them as files which can be reinstalled on a different machine 
#    easily.  Also backs up apt sources for apts installed with ppa.
################################################################################

# enable using ** 
shopt -s globstar

# Save configs here (may grab extras...)
# TODO: Don't get extra stuff here
mkdir ./configs
for file in /home/zach/**/.*rc; do
	sudo cp "$file" ./configs/
done

# APT backup
dpkg --get-selections | grep -v deinstalled > apt_list
cut -f1 apt_list > apt_list_tmp # remove installed column from file
mv apt_list_tmp apt_list
rsync -av /etc/apt/sources.list .
rsync -av /etc/apt/sources.list.d .


# Pip backup
pip list > pip_modules.txt
tail -n+3 pip_modules.txt | grep -Eo '^[^ ]+' > pip_tmp.txt
mv pip_tmp.txt pip_modules.txt
