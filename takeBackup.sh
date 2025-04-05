#!/bin/bash

backup_file=$(date |tr " " _ |tr ":" _)
rsync -avz /home/krishna/.tmux .
rsync -avz /home/krishna/.tmux.conf .
echo "$(backup_file): Backup started" >> /var/log/config-backup.log
zip -r /root/config/config_$backup_file /home/krishna/.config
cd /root/config
git add . 
if [[ -t 1 ]]; then
	read -p "Enter the commit name"
	backup_file=$REPLY
fi
git commit -m "$backup_file"
git push
