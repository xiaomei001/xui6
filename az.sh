#!/bin/bash


rm /etc/x-ui-yg/*
rm /usr/local/x-ui/*
rm /etc/systemd/system/multi-user.target.wants/x-ui.service
rm /etc/systemd/system/x-ui.service







# 指定要下载的文件的URL和目标目录
downloads=(
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui-linux-amd64 /usr/local/x-ui-linux-amd64.tar.gz"
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui-yg.db /etc/x-ui-yg/x-ui-yg.db"
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

tar -xzvf /usr/local/x-ui-linux-amd64.tar.gz
chmod +x /usr/local/x-ui/x-ui
chmod +x /usr/local/x-ui/bin/xray-linux-amd64
ln -s /usr/local/x-ui/x-ui.service /etc/systemd/system/multi-user.target.wants/x-ui.service
ln -s /usr/local/x-ui/x-ui.service /etc/systemd/system/x-ui.service



echo "安装完毕，现在重启"
reboot
