# chromium ref. https://blog.utermux.dev/ut/chromium.html
pkg i x11-repo -y
pkg rei tur-repo -y
pkg rei libexpat -y
pkg i chromium -y
pkg i ffmpeg -y
# ref. https://www.reddit.com/r/termux/comments/16dzkhg/libexpatso1_not_found_termux/?rdt=58766


# 安装nodejs, yarn
pkg i nodejs-lts -y
npm config set registry https://registry.npmmirror.com
npm i -g yarn

# 安装 koishi
if [ ! -f "~/koishi/koishi.yml" ]; then
    mkdir -p ~/koishi
    version=$(curl -Ls "https://api.github.com/repos/koishijs/boilerplate/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -L -o ~/boilerplate.zip https://mirror.ghproxy.com/https://github.com/koishijs/boilerplate/releases/download/${version}/boilerplate-${version}-linux-arm64-node20.zip
    unzip ~/boilerplate.zip -d ~/koishi
    rm ~/boilerplate.zip
    # 运行允许局域网访问
    sed -Ei 's/(([[:space:]]*)maxPort.*)/\1\n\2host: 0.0.0.0/' ~/koishi/koishi.yml
    # 修复 puppeteer 平台不兼容
    sed -i "s/'linux':/'android':/g" ~/koishi/node_modules/puppeteer-finder/lib/index.js
fi

curl -L -o $PREFIX/bin/koi https://gitee.com/initencunter/koimux_bot/raw/master/script/koi
chmod +x $PREFIX/bin/koi
echo "koishi 已安装，在 ~/koishi 目录"
echo "现在你可以使用命令 koi start"
echo "来启动 koishi"
echo "koi stop 停止 koishi"