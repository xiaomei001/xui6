#!/bin/bash


# 检查用户是否具有 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "请以 root 用户或使用 sudo 运行此脚本。"
  exit 1
fi
# 关闭x-ui
systemctl stop x-ui
# 删除旧的文件
rm /etc/x-ui-yg/*
mkdir -p /etc/x-ui-yg
echo "----------清空系统设置完毕，开始安装关闭文件----------"
sleep 1
# 指定要下载的文件的URL和目标目录
downloads=(
  "https://raw.githubusercontent.com/xiaomei001/xui6/main/x-ui-yg-sc.db /etc/x-ui-yg/x-ui-yg.db"
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
echo "----------关闭完成，重新开启x-ui----------"
# 安装文件


echo "安装完毕，2秒后重启"
sleep 1
echo "安装完毕，1秒后重启"
sleep 1
echo "--------------------重启并开始下一台机器安装--------------------"
reboot
