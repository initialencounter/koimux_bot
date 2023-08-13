echo "正在安装依赖"
if command -v yum &> /dev/null; then
    yum install git -y
else
    apt install git -y
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

echo 5秒后开始重装koishi,数据将丢失！！
sleep(1)
echo 4秒后开始重装koishi,数据将丢失！！
sleep(1)
echo 3秒后开始重装koishi,数据将丢失！！
sleep(1)
echo 2秒后开始重装koishi,数据将丢失！！
sleep(1)
echo 1秒后开始重装koishi,数据将丢失！！

echo "正在重装 koishi"
cd /root
rm koimux_bot -rf
git clone https://gitee.com/initencunter/koimux_bot
cd koimux_bot
npm i