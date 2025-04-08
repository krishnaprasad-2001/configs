#!/bin/bash

backup_file=$(date |tr " " _ |tr ":" _)
rsync -avz /home/krishna/.tmux .  /root/config/
rsync -avz /home/krishna/.tmux.conf .  /root/config/
rsync -avz /home/krishna/.config/neofetch  /root/config/
rsync -avz /home/krishna/.config/nvim  /root/config/
rsync -avz /home/krishna/.config/i3  /root/config/
rsync -avz /home/krishna/.config/nvim_backup  /root/config/
rsync -avz /home/krishna/.config/picom.conf  /root/config/
rsync -avz /home/krishna/.config/rofi  /root/config/
rsync -avz /home/krishna/.config/tmux  /root/config/
cd /root/config
git add . 
if [[ -t 1 ]]; then
	read -p "Enter the commit name"
	backup_file=$REPLY
fi
git commit -m "$backup_file"
git push
