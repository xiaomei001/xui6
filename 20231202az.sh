#!/bin/bash


# 检查用户是否具有 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "请以 root 用户或使用 sudo 运行此脚本。"
  exit 1
fi

# 安装bbr
wget --no-check-certificate -O /opt/bbr.sh https://github.com/xiaomei001/xui6/raw/main/bbr.sh
chmod 755 /opt/bbr.sh
/opt/bbr.sh
echo "bbr安装完毕"
sleep 1

# 删除旧的文件
rm /etc/x-ui-yg/*
rm /usr/local/x-ui/*
rm /etc/systemd/system/multi-user.target.wants/x-ui.service
rm /etc/systemd/system/x-ui.service
mkdir -p /usr/local/x-ui
mkdir -p /usr/local/x-ui/bin
mkdir -p /etc/x-ui-yg
sleep 1

# 指定要下载的文件的URL和目标目录
downloads=(
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/x-ui.service /usr/local/x-ui/x-ui.service"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/x-ui /usr/local/x-ui/x-ui"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/bin/LICENSE /usr/local/x-ui/bin/LICENSE"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/bin/README.md /usr/local/x-ui/bin/README.md"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/bin/geoip.dat /usr/local/x-ui/bin/geoip.dat"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/bin/geosite.dat /usr/local/x-ui/bin/geosite.dat"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui/bin/xray-linux-amd64 /usr/local/x-ui/bin/xray-linux-amd64"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui-yg.db /etc/x-ui-yg/x-ui-yg.db"
)

# 下载文件并检查下载是否成功
for download in "${downloads[@]}"; do
  url="${download%% *}"
  destination="${download#* }"

  # 检查文件是否已存在
  if [ -e "$destination" ]; then
    echo "文件已存在: $destination，跳过下载。"
  else
    wget -O "$destination" "$url"
    if [ $? -ne 0 ]; then
      echo "文件下载失败: $url"
      exit 1
    fi
  fi
done

# 安装文件
chmod +x /usr/local/x-ui/x-ui
chmod +x /usr/local/x-ui/bin/xray-linux-amd64
ln -s /usr/local/x-ui/x-ui.service /etc/systemd/system/multi-user.target.wants/x-ui.service
ln -s /usr/local/x-ui/x-ui.service /etc/systemd/system/x-ui.service


sleep 1
echo "安装完毕，2秒后重启"
sleep 1
reboot
