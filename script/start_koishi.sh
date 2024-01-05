
if uname -a | grep -q "Android"; then
    echo "当前会话不处于proot，请在proot容器内运行该脚本"
    echo "请联系作者"
    exit 1
else
    echo "您的会话正处于 proot 容器内"
fi

if command -v node &> /dev/null; then
    if [ -f "/root/koimux_bot/package.json" ]; then
        echo "正在启动 koishi"
        cd /root/koimux_bot
        npm start
    else
        echo "koishi 未安装"
        echo "请运行 bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)" 来重装 koishi"
    fi
else
    echo "Node.js 未安装"
    echo "请运行 bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_nodejs.sh)" 来安装 Node.js"
fi
