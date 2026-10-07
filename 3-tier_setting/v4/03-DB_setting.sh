#!/bin/bash
# mysql을 통한 데이터베이스 생성

echo ===================================
echo 데이터베이스 생성
echo ===================================

DB_USER=$1
DB_PASS=$2

if [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
    echo "❌ 에러: 전달된 인자가 없습니다."
    exit 1
fi

sudo mysql <<EOF
CREATE DATABASE myapp;
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON myapp.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF