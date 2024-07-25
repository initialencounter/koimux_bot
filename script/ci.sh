#!/bin/bash

echo "下载底包"
curl -L -o koimux-base.tar.gz https://github.com/initialencounter/koimux_bot/releases/download/base/koimux-base.tar.gz

echo "解压底包"
mkdir koimux
tar zxf koimux-base.tar.gz -C koimux

echo "升级 nodejs"
version=$(curl -L https://grimler.se/termux-packages-24/dists/stable/main/binary-aarch64/Packages | grep '^Package: nodejs-lts' -A 10 | grep '^Version:' | awk '{print $2}')
curl -L -o nodejs.deb https://grimler.se/termux-packages-24/pool/main/n/nodejs/nodejs_${version}_aarch64.deb
dpkg -x nodejs.deb koimux

echo "安装 koishi"
version=$(curl -Ls "https://api.github.com/repos/koishijs/boilerplate/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
curl -L -o boilerplate.zip https://mirror.ghproxy.com/https://github.com/koishijs/boilerplate/releases/download/${version}/boilerplate-${version}-linux-arm64-node20.zip
unzip boilerplate.zip -d koimux/data/data/com.termux/files/home/koishi

echo "允许局域网访问"
sed -Ei 's/(([[:space:]]*)maxPort.*)/\1\n\2host: 0.0.0.0/' koimux/data/data/com.termux/files/home/koishi/koishi.yml

echo "安装 koi"
curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/koi > koimux/data/data/com.termux/files/usr/bin/koi
chmod +x koimux/data/data/com.termux/files/usr/bin/koi