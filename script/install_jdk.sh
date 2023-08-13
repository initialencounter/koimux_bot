# 该脚本只适用于arm64架构

echo "正在安装依赖"
if command -v tar &> /dev/null; then
    echo "tar 已安装"
else
    if command -v yum &> /dev/null; then
        yum install tar -y
    else
        apt install tar -y
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
    echo "export PATH=\$PATH:/usr/local/jdk-20.0.2/bin" >> ~/.bashrc
    echo "export JAVA_HOME=/usr/local/jdk-20.0.2" >> ~/.bashrc
    source ~/.bashrc
fi