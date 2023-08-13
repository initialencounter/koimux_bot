
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


# xz
if command -v xz &> /dev/null; then
    echo "xz 已安装"
else
    if command -v yum &> /dev/null; then
        yum install xz -y
    else
        apt install xz-utils curl -y
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
    echo "export PATH=\$PATH:/usr/local/node-v20.5.0-linux-arm64/bin" >> /etc/profile
    source /etc/profile
    # 设置国内 npm 镜像源
    npm config set registry https://registry.npmmirror.com
fi