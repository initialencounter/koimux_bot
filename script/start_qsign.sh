if command -v screen &> /dev/null; then
    echo "screen 已安装"
else
    if command -v yum &> /dev/null; then
        yum install epel-release -y
        yum install screen -y
        chmod 777 /run/screen
    else
        apt install screen -y
    fi 
fi
screen -wipe

if command -v java &> /dev/null; then
    echo java已安装
else 
    echo 未安装java!,正在安装java
    cd /usr/local
    rm jdk-20_linux-aarch64_bin.tar.gz -f
    curl -O https://download.oracle.com/java/20/latest/jdk-20_linux-aarch64_bin.tar.gz
    rm jdk-20.0.2 -rf
    tar -zxvf jdk-20_linux-aarch64_bin.tar.gz
    rm jdk-20_linux-aarch64_bin.tar.gz -f
    echo "export PATH=\$PATH:/usr/local/jdk-20.0.2/bin" >> ~/.bashrc
    echo "export JAVA_HOME=/usr/local/jdk-20.0.2" >> ~/.bashrc
    source ~/.bashrc
    if command -v java &> /dev/null; then
        echo java 安装成功
    else
        echo java 安装失败
    fi
fi

screen -wipe
if screen -list | grep -q "qsignServer"; then
        echo "qsignServer 已启动，是否要重启？"
else
    # 启动 qsinServer
    echo "正在启动 qsinServer"
    screen -dmS qsignServer
    screen -S qsignServer -p 0 -X stuff "cd /root/unidbg-fetch-qsign-1.1.6; bash bin/unidbg-fetch-qsign --basePath=txlib/8.9.63$(printf \\r)"
    echo "qsinServer,已启动，输入screen -r qsignSercer查看输出，ctrl+a+d挂起"
fi  