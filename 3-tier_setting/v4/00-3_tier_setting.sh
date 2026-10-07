#!/bin/bash
# mysql, tomcat, nginx를 통한 3-tier 세팅 자동화 프로그램

echo ===================================
echo 3-tier 세팅 자동화 프로그램 실행
echo ===================================

VAULT_DIR="/tmp/my_secret_vault"
sudo mkdir -p $VAULT_DIR
sudo mount -t tmpfs -o size=1m,mode=700 tmpfs $VAULT_DIR

bash ./01-Download.sh

source ./02-Config.sh
echo "$MY_PW" | sudo tee $VAULT_DIR/password.txt > /dev/null
unset MY_PW

bash ./03-DB_setting.sh "$MY_ID" "$(sudo cat $VAULT_DIR/password.txt)"

sudo shred -u -z -n 3 $VAULT_DIR/password.txt  
sudo umount $VAULT_DIR                           
sudo rmdir $VAULT_DIR