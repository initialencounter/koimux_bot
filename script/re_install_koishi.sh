
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
if command -v yum &> /dev/null; then
    apt install git curl -y
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
    curl -O https://cdn.npmmirror.com/binaries/node/v20.10.0/node-v20.10.0-linux-arm64.tar.xz
    # 解压并删除 nodejs 源文件
    tar -xvf node-v20.10.0-linux-arm64.tar.xz
    rm node-v20.10.0-linux-arm64.tar.xz -f
    echo "export PATH=\$PATH:/usr/local/node-v20.10.0-linux-arm64/bin" >> /etc/profile
    source /etc/profile
fi

echo 5秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 4秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 3秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 2秒后开始重装koishi,数据将丢失！！ctrl+c结束运行
sleep 1
echo 1秒后开始重装koishi,数据将丢失！！ctrl+c结束运行

echo "正在重装 koishi"
cd /root
rm koimux_bot -rf
git clone https://gitee.com/initencunter/koimux_bot
cd koimux_bot
yarn install