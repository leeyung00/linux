#!/bin/bash

echo "========================================="
echo "   3-Tier 인프라 자동 구축 스크립트"
echo "========================================="

# 아이디 입력받기
read -p "▶ 생성할 MySQL 데이터베이스 아이디를 입력하세요: " MY_ID

# 비밀번호 입력받기
read -s -p "▶ 사용할 MySQL 비밀번호를 입력하세요: " MY_PW
echo "" 

read -s -p "▶ 비밀번호를 한 번 더 입력하세요 (확인): " MY_PW_CONFIRM
echo ""

# 비밀번호 확인 로직
if [ "$MY_PW" != "$MY_PW_CONFIRM" ]; then
    echo "비밀번호가 일치하지 않습니다. 스크립트를 종료합니다."
    exit 1
fi

echo "========================================="
echo "입력하신 ID [ ${MY_ID} ] 로 설정을 시작합니다."
echo "========================================="

# 필수 패키지 설치
echo 패키지 설치
sudo apt update && sudo apt install mysql-server openjdk-17-jdk nginx -y
sudo systemctl enable --now nginx mysql
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.119/bin/apache-tomcat-9.0.119.tar.gz
sudo mkdir -p /opt/tomcat
sudo tar -xf apache-tomcat-9.0.119.tar.gz -C /opt/tomcat --strip-components=1
sudo /opt/tomcat/bin/startup.sh

# DB 설정
echo 데이터베이스 세팅 중
sudo mysql <<EOF
CREATE DATABASE myapp;
CREATE USER '${MY_ID}'@'localhost' IDENTIFIED BY '${MY_PW}';
GRANT ALL PRIVILEGES ON myapp.* TO '${MY_ID}'@'localhost';
FLUSH PRIVILEGES;
EOF

echo 모든 인프라 구축 및 DB 설정이 완료되었습니다