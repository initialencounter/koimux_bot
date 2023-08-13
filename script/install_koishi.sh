echo "正在安装依赖"
# git
if command -v git &> /dev/null; then
    echo "git 已安装"
else
    if command -v yum &> /dev/null; then
        yum install git -y
    else
        apt install git -y
    fi
fi
# xz
if command -v xz &> /dev/null; then
    echo "xz 已安装"
else
    if command -v yum &> /dev/null; then
        yum install xz -y
    else
        apt install xz-utils -y
    fi
fi
# tar
if command -v tar &> /dev/null; then
    echo "tar 已安装"
else
    if command -v yum &> /dev/null; then
        yum install tar -y
    else
        apt install tar -y
    fi
fi

if command -v npm &> /dev/null; then
    echo "npm 已安装"
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

if [ -f "/root/koimux_bot/package.json" ]; then
    echo "koishi 已安装，在 /root/koimux_bot 目录"
else
    echo "正在安装 koishi"
    cd /root
    rm koimux_bot -rf
    git clone https://gitee.com/initencunter/koimux_bot
    cd koimux_bot
    npm i
fi