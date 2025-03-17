#!/bin/bash

# Check if moreutils app is installed
if [ ! command -v ts &>/dev/null ]; then
    echo "Installing moreutils..."
    sudo apt install moreutils -y
fi

# Create log file
LOG_FILE=/var/log/system_update.log
if [ ! -f $LOG_FILE ];then
        sudo touch $LOG_FILE
        sudo chmod a+w $LOG_FILE
else
        sudo chmod a+w $LOG_FILE
fi

# Updating Packages
echo "--[Updating Packages]--" | ts '[%Y-%m-%d %H:%M:%S]' 2>&1 | tee -a $LOG_FILE
sudo apt-get update -y | ts '[%Y-%m-%d %H:%M:%S]' 2>&1 | tee -a $LOG_FILE

# Upgrading Packages
echo " " >> $LOG_FILE
echo "--[Upgrading Packages]--" | ts '[%Y-%m-%d %H:%M:%S]' 2>&1 | tee -a $LOG_FILE
sudo apt-get upgrade -y | ts '[%Y-%m-%d %H:%M:%S]' 2>&1 | tee -a $LOG_FILE

echo " " >> $LOG_FILE
echo "---------------------------------------------------" >> $LOG_FILE
echo " " >> $LOG_FILE

echo "Package Update and Upgrade done Successfully"
exit 0