
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


echo "正在安装依赖"
# git
if command -v git &> /dev/null; then
    echo "git 已安装"
else
    apt install git curl -y
fi
# xz
if command -v xz &> /dev/null; then
    echo "xz 已安装"
else
    apt install xz-utils -y
fi
# tar
if command -v tar &> /dev/null; then
    echo "tar 已安装"
else
    apt install tar -y
fi

if command -v node &> /dev/null; then
    echo "Node.js 已安装"
else
    echo "正在安装 Node.js"
    cd /usr/local
    rm node-v20.10.0-linux-arm64.tar.xz -f
    curl -O https://npmmirror.com/mirrors/node/v20.10.0/node-v20.10.0-linux-arm64.tar.xz
    # 解压并删除 nodejs 源文件
    tar -xvf node-v20.10.0-linux-arm64.tar.xz
    rm node-v20.10.0-linux-arm64.tar.xz -f
    echo "export PATH=\$PATH:/usr/local/node-v20.10.0-linux-arm64/bin" >> /etc/profile
    source /etc/profile
fi

if command -v yarn &> /dev/null; then
    echo "Yarn 已安装"
else
    echo "正在安装 Yarn"
    export COREPACK_NPM_REGISTRY=https://registry.npmmirror.com
    corepack enable
fi

if [ -f "/root/boilerplate/package.json" ]; then
    echo "koishi 已安装，在 /root/boilerplate 目录"
else
    echo "正在安装 koishi"
    cd /root
    rm boilerplate -rf
    git clone https://mirror.ghproxy.com/https://github.com/koishijs/boilerplate
    cd boilerplate
    yarn install
fi