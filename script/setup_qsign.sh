if uname -a | grep -q "Android"; then
    echo "当前会话不处于proot，请在proot容器内运行该脚本"
    echo "请联系作者"
    exit 1
else
    echo "您的会话正处于 proot 容器内"
fi

if command -v yum &> /dev/null; then
    yum install unzip -y
else
    apt install unzip curl -y
fi 


if [ -f "/root/unidbg-fetch-qsign-1.1.6/txlib/8.9.63/config.json" ]; then
    echo qsign已安装
else
    cd /root
    rm -f unidbg-fetch-qsign-1.1.6.zip
    rm -rf unidbg-fetch-qsign-1.1.6
    curl -O https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.6/unidbg-fetch-qsign-1.1.6.zip
    unzip unidbg-fetch-qsign-1.1.6.zip
    rm -f unidbg-fetch-qsign-1.1.6.zip
fi