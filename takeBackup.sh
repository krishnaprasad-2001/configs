#!/bin/bash

backup_file=$(date |tr " " _ |tr ":" _)
zip -r /root/config/config_$backup_file /home/krishna/.config
cd /root/config
git add . 
git commit -m "$backup_file"
git push
