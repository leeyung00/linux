#!/bin/bash

echo ===================================
echo mysql, java, nginx, tomcat 설치
echo ===================================

# mysql, java, nginx 설치 로직
sudo apt update
sudo apt install mysql-server openjdk-17-jdk nginx -y
sudo systemctl enable --now nginx mysql

# tomcat 설치 및 실행
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.119/bin/apache-tomcat-9.0.119.tar.gz
sudo mkdir -p /opt/tomcat
sudo tar -xf apache-tomcat-9.0.119.tar.gz -C /opt/tomcat --strip-components=1
sudo /opt/tomcat/bin/startup.sh

# 설치 프로그램 확인
echo 설치 프로그램 확인
sudo systemctl status nginx mysql --no-pager
java -version
echo 인프라 구축이 성공적으로 끝났습니다.