#!/bin/sh

# 获取 db 容器的 IP 地址
DB_IP=$(getent hosts db | awk '{ print $1 }')

# 更新 JSON 文件中的 DB IP 地址
jq --arg db_ip "$DB_IP" '.database.host = $db_ip' /var/www/config/minimal-config.json > /var/www/config/minimal-config.tmp && mv /var/www/config/minimal-config.tmp /var/www/config/minimal-config.json
