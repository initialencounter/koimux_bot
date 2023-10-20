# 检测运行环境
if uname -a | grep -q "Android"; then
    echo "当前会话不处于proot，请在proot容器内运行该脚本"
    echo "请联系作者"
    exit 1
else
    echo "您的会话正处于 proot 容器内"
fi

arch=$(uname -m)
if [[ $arch == "aarch64" ]]; then
    echo "当前系统是ARMv8架构"
else
    echo "该脚本只适用于AMRv8架构"
    exit 1
fi

# 安装依赖
echo "正在安装依赖"
apt update
apt install tar xz-utils screen git unzip curl -y

# 安装nodejs
if command -v npm &> /dev/null; then
    echo "npm 已安装"
else
    echo "正在安装 Node.js"
    cd /usr/local
    rm node-v18.18.0-linux-arm64.tar.xz -f
    curl -O https://npmmirror.com/mirrors/node/v18.18.0/node-v18.18.0-linux-arm64.tar.xz
    # 解压并删除 nodejs 源文件
    tar -xvf node-v18.18.0-linux-arm64.tar.xz
    rm node-v18.18.0-linux-arm64.tar.xz -f
    echo "export PATH=\$PATH:/usr/local/node-v18.18.0-linux-arm64/bin" >> /etc/profile
    source /etc/profile
    # 设置国内 npm 镜像源
    npm config set registry https://registry.npmmirror.com
fi

# 安装koishi
if [ -f "/root/koimux_bot/node_modules/.bin/koishi" ]; then
    echo "koishi 已安装，在 /root/koimux_bot 目录"
else
    echo "正在安装 koishi"
    cd /root
    rm koimux_bot -rf
    git clone https://gitee.com/initencunter/koimux_bot
    cd koimux_bot
    npm i
fi

# 启动koishi
if command -v npm &> /dev/null; then
    if [ -f "/root/koimux_bot/package.json" ]; then
        echo "正在启动 koishi"
        cd /root/koimux_bot
        npm start
    else
        echo "koishi 未安装"
        echo "请运行 bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)" 来重装 koishi"
    fi
else
    echo "npm 未安装"
    echo "请运行 bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_nodejs.sh)" 来安装npm"
fi
