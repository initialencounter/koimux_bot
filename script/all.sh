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
if command -v yum &> /dev/null; then
        yum install epel-release tar xz git unzip -y
        yum install screen newt -y

    else
        apt install tar xz-utils screen git unzip curl -y
    fi

# 安装java
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
    echo "export PATH=\$PATH:/usr/local/jdk-20.0.2/bin" >> /etc/profile
    echo "export JAVA_HOME=/usr/local/jdk-20.0.2" >> /etc/profile
    source /etc/profile
    if command -v java &> /dev/null; then
        echo java 安装成功
    else
        echo java 安装失败
    fi
fi

# 安装nodejs
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
    echo "export PATH=\$PATH:/usr/local/node-v20.5.0-linux-arm64/bin" >> /etc/profile
    source /etc/profile
    # 设置国内 npm 镜像源
    npm config set registry https://registry.npmmirror.com
fi

# 安装qsign
if [ -f "/root/unidbg-fetch-qsign-1.1.9/txlib/8.9.63/config.json" ]; then
    echo qsign已安装
else
    cd /root
    rm -rf unidbg-fetch-qsign*
    curl -o unidbg-fetch-qsign-1.2.1.zip https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.2.1/unidbg-fetch-qsign-1.2.1.zip
    unzip unidbg-fetch-qsign-1.2.1.zip
    rm -f *.zip
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

# 启动qsign
chmod 777 /run/screen
screen -wipe
cd /root/unidbg-fetch-qsign-1.1.9
if screen -list | grep -q "qsignServer"; then
    screen -S qsignServer -X quit
else
    # 启动 qsinServer
    echo "正在启动 qsinServer"
fi
screen -dmS qsignServer
screen -S qsignServer -p 0 -X stuff "cd /root/unidbg-fetch-qsign-1.1.9; bash bin/unidbg-fetch-qsign --basePath=txlib/8.9.63$(printf \\r)"
echo "qsinServer,已启动，输入screen -r qsignSercer查看输出，ctrl+a+d挂起"

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
