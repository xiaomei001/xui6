#!/bin/bash

# 从指定 URL 下载 IP 地址列表文件
ip_list_url="https://raw.githubusercontent.com/xiaomei001/xui6/main/IP/ip20231105.80.txt"
ip_list_file="ip.txt"

# 下载 IP 地址列表文件
wget -O "$ip_list_file" "$ip_list_url"

# 检查文件是否成功下载
if [ -s "$ip_list_file" ]; then
  echo "IP 地址列表下载成功。"
else
  echo "无法下载 IP 地址列表。"
  exit 1
fi

# 读取 IP 地址列表文件并执行命令
while IFS= read -r ip; do
  echo "在 $ip 上运行命令"
  sshpass -p rOck123456a ssh -o StrictHostKeyChecking=no root@"$ip" "bash <(wget -qO- -o- https://github.com/xiaomei001/xui6/raw/main/az.sh)"
done < "$ip_list_file"
