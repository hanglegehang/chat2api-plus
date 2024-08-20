#!/bin/bash
set -e

## 克隆仓库到本地
echo "clone repository..."
git clone -b main --depth=1  https://github.com/hanglegehang/chat2api-plus.git chat2api-plus

## 进入目录
cd chat2api-plus

docker compose pull
docker compose up -d --remove-orphans

## 提示信息
echo "服务启动成功，请访问 http://localhost:8700"
echo "管理员后台地址 http://localhost:8700/admin"
echo "管理员账号: admin"
echo "管理员密码: 123456"
echo "请及时修改管理员密码"