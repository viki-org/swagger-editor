#!/bin/bash

eval "$(ssh-agent -s)"
ssh-add /root/.ssh/deploykey
cd /opt/swagger-editor/

for folder in `ls -d /opt/swagger-editor/pull/repos/*/`
do
 echo "$folder"
 cd "$folder"
 git pull origin master
done

#Run the merge
/opt/swagger-editor/pull/merge.rb

#Backup existing yaml

BACKUP_DIR=/var/log/supervisor/backup
mkdir -p $BACKUP_DIR

DATE=`date +%Y-%m-%d`
cp /opt/swagger-editor/spec-files/default.yaml "$BACKUP_DIR/spec.$DATE"
cp /opt/swagger-editor/spec-files/test.yaml /opt/swagger-editor/spec-files/default.yaml

