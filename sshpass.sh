#!/bin/bash
rm /ip/*
mkdir -p /ip
# 指定要下载的文件的URL和目标目录
downloads=(
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/IP/ip20231105.80.txt /ip/ip.txt"
)

# 下载文件并检查下载是否成功
for download in "${downloads[@]}"; do
  url="${download%% *}"
  destination="${download#* }"
  wget -O "$destination" "$url"
  if [ $? -ne 0 ]; then
    echo "文件下载失败: $url"
    exit 1
  fi
done

# 从 /ip/ip.txt 文件中读取 IP 地址列表
ip_list_file="/ip/ip.txt"

# 检查文件是否存在
if [ ! -f "$ip_list_file" ]; then
  echo "IP 地址列表文件 '$ip_list_file' 不存在。"
  exit 1
fi

# 读取 IP 地址列表文件并执行命令
while IFS= read -r ip; do
  echo "在 $ip 上运行命令"
  sshpass -p rOck123456a ssh -o StrictHostKeyChecking=no root@"$ip" "bash <(wget -qO- -o- https://github.com/xiaomei001/xui6/raw/main/az.sh)"
done < "$ip_list_file"
