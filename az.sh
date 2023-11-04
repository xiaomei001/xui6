#!/bin/bash

# 下载并执行远程脚本
bash <(wget -qO- -o- https://github.com/233boy/Xray/raw/main/install.sh)
rm /etc/xray/conf/*
# 指定要下载的文件的URL和目标目录
downloads=(
  "https://raw.githubusercontent.com/xiaomei001/-/main/Shadowsocks-27843.json /etc/xray/conf/Shadowsocks-27843.json"
  "https://raw.githubusercontent.com/xiaomei001/-/main/VMess-QUIC-58818.json /etc/xray/conf/VMess-QUIC-58818.json"
  "https://raw.githubusercontent.com/xiaomei001/-/main/VMess-mKCP-28859.json /etc/xray/conf/VMess-mKCP-28859.json"
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

# 执行 xray 的重启命令
xray bbr
echo "安装完毕，现在重启"
reboot
