#!/bin/bash

CUR_DATE=$(date +"%Y-%m-%d")
FILE_NAME=HOME_$CUR_DATE.tar

cd /
sudo tar -cf $FILE_NAME home
sudo mv $FILE_NAME /var/backups/

cd /var/backups
echo "Please find the attached Daily Home dir packup." | mail -s "Subject: Daily Packup" -A $FILE_NAME 3amr.7assan1993@gmail.com

echo "Backup Done"
exit 0