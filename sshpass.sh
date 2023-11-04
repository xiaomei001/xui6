#!/bin/bash

# 要执行的命令
command_to_run="bash <(wget -qO- -o- https://github.com/xiaomei001/xui6/raw/main/az.sh)"

# 下载 IP 地址列表文件
ip_file_url="https://raw.githubusercontent.com/xiaomei001/xui6/main/IP/ip20231105.80.txt"
ip_file="ip.txt"

# SSH 密码
ssh_password="rOck123456a"

# 下载 IP 地址列表文件
wget -O "$ip_file" "$ip_file_url"

# 检查 IP 文件是否存在
if [ ! -f "$ip_file" ]; then
  echo "IP file '$ip_file' not found."
  exit 1
fi

# 读取 IP 列表并在每台主机上执行命令
while IFS= read -r ip; do
  echo "Running command on $ip"
  sshpass -p "$ssh_password" ssh root@"$ip" "$command_to_run"
done < "$ip_file"
