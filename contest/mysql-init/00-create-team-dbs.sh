#!/bin/bash
# Chạy tự động khi container MySQL khởi tạo lần đầu (docker-entrypoint-initdb.d).
# Tạo 1 database riêng cho mỗi đội và import schema.sql giống hệt nhau vào từng database.
set -e

TEAM_COUNT="${TEAM_COUNT:-6}"

for i in $(seq 1 "$TEAM_COUNT"); do
  DB_NAME="team${i}_electronic_store"
  echo ">> Khởi tạo database cho đội $i: $DB_NAME"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" "${DB_NAME}" < /schema-source/schema.sql
done

echo ">> Hoàn tất khởi tạo $TEAM_COUNT database cho các đội."
