#!/bin/bash

yum install tar xz unzip epel-release -y
yum install screen -y
chmod 777 /run/screen
screen -wipe

function ECHO_LINE(){
    max=5
    for i in {1..$max}
    do
        echo ""
    done
}
# 安装nodejs
function I_NODE(){
    ECHO_LINE
    if command -v node &> /dev/null; then
        echo "Node.js 已安装"
    else
        echo "正在安装 Node.js"
        cd /usr/local
        rm node-v20.5.0-linux-arm64.tar.xz -f
        curl -O https://cdn.npmmirror.com/binaries/node/v20.5.0/node-v20.5.0-linux-arm64.tar.xz
        # 解压并删除 nodejs 源文件
        tar -xvf node-v20.5.0-linux-arm64.tar.xz
        rm node-v20.5.0-linux-arm64.tar.xz -f
        echo "export PATH=\$PATH:/usr/local/node-v20.5.0-linux-arm64/bin" >> ~/.bashrc
        source ~/.bashrc
        # 设置国内 npm 镜像源
        npm config set registry https://registry.npmmirror.com
    fi
}

# 安装 KOISHI
function I_KOISHI(){
    ECHO_LINE
    echo 正在启动 Koishi
    cd ~/koimux_bot
    npm i
    npm start
}

# 安装JDK
function I_JDK(){
    ECHO_LINE
    if command -v java &> /dev/null; then
        echo "jdk 已安装"
    else
        echo "正在安装 jdk-20"
        cd /usr/local
        rm jdk-20_linux-aarch64_bin.tar.gz -f
        curl -O https://download.oracle.com/java/20/latest/jdk-20_linux-aarch64_bin.tar.gz
        rm jdk-20.0.2 -rf
        tar -zxvf jdk-20_linux-aarch64_bin.tar.gz
        rm jdk-20_linux-aarch64_bin.tar.gz -f
        echo "export PATH=\$PATH:/usr/local/jdk-20.0.2/bin" >> ~/.bashrc
        echo "export JAVA_HOME=/usr/local/jdk-20.0.2" >> ~/.bashrc
        source ~/.bashrc
    fi
}

# 解压 qsignServer
function UNZIP_QS(){
    ECHO_LINE
    if [ -f "/root/unidbg-fetch-qsign-1.1.7/txlib/8.9.63/config.json" ]; then
        echo "已解压 qsignServer"
    else
        echo "正在解压 qsignServer"
        cd /root
        unzip unidbg-fetch-qsign-1.1.7.zip
        rm unidbg-fetch-qsign-1.1.7.zip
        echo qsignServer 解压完成
    fi
}

# 启动 qsignServer
function START_QS(){
    ECHO_LINE
    if screen -list | grep -q "qsignServer"; then
        echo "qsignServer 已启动，是否要重启？"
    else
        # 启动 qsinServer
        echo "正在启动 qsinServer"
        screen -dmS qsignServer
        screen -S qsignServer -p 0 -X stuff "cd /root/unidbg-fetch-qsign-1.1.7; bash bin/unidbg-fetch-qsign --basePath=txlib/8.9.63$(printf \\r)"
    fi
}

# 重启 qsignServer
function RESTART_QS(){
    ECHO_LINE
    if screen -list | grep -q "qsignServer"; then
        screen -S qsignServer -X quit
        START_QS
    else
        # 启动 qsinServer
        screen -dmS qsignServer
        screen -S qsignServer -p 0 -X stuff "cd ~/unidbg-fetch-qsign-1.1.7; bash bin/unidbg-fetch-qsign --basePath=txlib/8.9.63$(printf \\r)"
    fi
}

I_NODE
I_JDK
UNZIP_QS
START_QS
I_KOISHI