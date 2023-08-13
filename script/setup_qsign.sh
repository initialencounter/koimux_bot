if command -v yum &> /dev/null; then
    yum install unzip -y
else
    apt install unzip -y
fi 


if [ -f "/root/unidbg-fetch-qsign-1.1.7/txlib/8.9.63/config.json" ]; then
    echo qsign已安装
else
    cd /root
    rm -f unidbg-fetch-qsign-1.1.6.zip
    rm -rf unidbg-fetch-qsign-1.1.6
    curl -O https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.6/unidbg-fetch-qsign-1.1.6.zip
    unzip unidbg-fetch-qsign-1.1.6.zip