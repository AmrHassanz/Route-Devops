#!/bin/bash

CUR_DATE=$(date +"%Y%m%d")
BACKUP_DIR=/var/log/backup
FILE_NAME=journalctl_$CUR_DATE

# Create log dir
if [ ! -d $BACKUP_DIR ];then
        sudo mkdir $BACKUP_DIR
        sudo chmod -R a+w $BACKUP_DIR
else
        sudo chmod -R a+w $BACKUP_DIR
fi

# Check if gzip  app is installed
if [ ! command -v gzip &>/dev/null ]; then
    echo "Installing gzip..."
    sudo apt install gzip -y
fi

cd /var/log/backup/

journalctl --since "-7 day" >> $FILE_NAME.log
tar -czf $FILE_NAME.tar.gz $FILE_NAME.log
rm -rf $FILE_NAME.log

echo "Backup Done"
exit 0
