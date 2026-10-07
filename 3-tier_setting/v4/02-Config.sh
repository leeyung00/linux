#!/bin/bash
# 설정 파일

# db 아이디, 비밀번호 사용자 입력
echo ===================================
echo 데이터베이스 계정 설정
echo ===================================
read -p "▶ 생성할 MySQL 데이터베이스 아이디를 입력하세요: " MY_ID
read -s -p "▶ 사용할 MySQL 비밀번호를 입력하세요: " MY_PW
echo ""
read -s -p "▶ 비밀번호를 한 번 더 입력하세요 (확인): " MY_PW_CONFIRM
echo ""

# 비밀번호 검증 로직
if [ "$MY_PW" != "$MY_PW_CONFIRM" ]; then
    echo "에러: 비밀번호가 일치하지 않습니다. 스크립트를 종료합니다."
    exit 1
fi
echo "입력한 ${MY_ID}로 데이터 베이스 설정"