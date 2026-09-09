#!/bin/bash

# mysql에서 사용할 아이디, 패스워드
MY_ID="testId"
MY_PW="testPass"

# 필수 패키지 설치
echo mysql, java, nginx 설치를 진행합니다.
sudo apt update
sudo apt install mysql-server openjdk-17-jdk nginx -y
sudo systemctl enable --now nginx mysql
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.119/bin/apache-tomcat-9.0.119.tar.gz
sudo mkdir -p /opt/tomcat
sudo tar -xf apache-tomcat-9.0.119.tar.gz -C /opt/tomcat --strip-components=1
sudo /opt/tomcat/bin/startup.sh

# 디비 설정
echo "데이터베이스 설정"
sudo mysql <<EOF
CREATE DATABASE myapp;
CREATE USER '${MY_ID}'@'localhost' IDENTIFIED BY '${MY_PW}';
GRANT ALL PRIVILEGES ON myapp.* TO '${MY_ID}'@'localhost';
FLUSH PRIVILEGES;
EOF

# 상태 점검
echo 설치 프로그램 확인
sudo systemctl status nginx mysql
java -version
echo 인프라 구축이 성공적으로 끝났습니다.