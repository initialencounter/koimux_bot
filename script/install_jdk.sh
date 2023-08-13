
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
if command -v tar &> /dev/null; then
    echo "tar 已安装"
else
    if command -v yum &> /dev/null; then
        yum install tar -y
    else
        apt install tar curl -y
    fi
fi

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