if uname -a | grep -q "Android"; then
    echo "运行环境正确"
else
    echo "您的会话正处于 proot 容器内"
    exit 1
fi

AH="arm64"
sys_name="debian-sid"
BAGNAME="rootfs.tar.xz"
SLEEP_TIME=0.1

cd ~
# 检测是否安装过
if [ -f "$sys_name-$AH/root/.bashrc" ]; then
    echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"
    exit 1
else
    echo 正在安装依赖
fi

mkdir $sys_name-$AH

echo "正在切换apt镜像源"

echo "deb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main" > $PREFIX/etc/apt/sources.list

apt update
apt install neofetch wget aria2 proot git -y


echo "即将下载安装debian-sid"
wget -O default.html "https://mirrors.bfsu.edu.cn/lxc-images/images/debian/sid/arm64/default"
target=$(grep -m 1 -o '<td class="link"><a href=".*" title="' "default.html"| sed 's/<[^>]*>//g')
date="${target:9:-10}"
rm -rf default.html
DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/sid/arm64/default/$date/rootfs.tar.xz"
echo "======================================="
echo "==============开始下载================="

echo $DEF_CUR
echo "======================================="


# 下载rootfs
if [ -e ${BAGNAME} ]; then
    tar -xvf rootfs.tar.xz -C $sys_name-$AH
else
	wget ${DEF_CUR}
	tar -xvf rootfs.tar.xz -C $sys_name-$AH
rm -rf ${BAGNAME}
echo -e "$sys_name-$AH 系统已下载，文件夹名为$sys_name-$AH"
fi
sleep $SLEEP_TIME

# 配置容器
neofetch >>systeminfo.log
hostinfo=$(cat systeminfo.log |grep Host |awk -F':' '{print $2}')
echo "更新DNS"
sleep $SLEEP_TIME
echo "127.0.0.1 localhost" > $sys_name-$AH/etc/hosts
rm $sys_name-$AH/etc/hostname
echo "$hostinfo" > $sys_name-$AH/etc/hostname
echo "127.0.0.1 $hostinfo" > $sys_name-$AH/etc/hosts
rm -rf $sys_name-$AH/etc/resolv.conf &&
echo "nameserver 223.5.5.5
nameserver 223.6.6.6
nameserver 114.114.114.114" >$sys_name-$AH/etc/resolv.conf
echo "设置时区"
sleep $SLEEP_TIME
rm systeminfo.log
echo "export  TZ='Asia/Shanghai'" >> $sys_name-$AH/root/.bashrc
echo "export  TZ='Asia/Shanghai'" >> $sys_name-$AH/etc/profile
echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name-$AH/etc/profile
echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name-$AH/root/.bashrc
echo 检测到你没有权限读取/proc内的所有文件
echo 将自动伪造新文件
mkdir proot_proc
aria2c -o proc.tar.xz -d ./proot_proc/ -x 16 https://gitee.com/yudezeng/proot_proc/raw/master/proc.tar.xz
sleep $SLEEP_TIME
mkdir tmp
echo 正在解压伪造文件

tar -xvJf proot_proc/proc.tar.xz -C tmp 
cp -r tmp/usr/local/etc/tmoe-linux/proot_proc tmp/
sleep $SLEEP_TIME
echo 复制文件
cp -r tmp/proot_proc $sys_name-$AH/etc/proc
sleep $SLEEP_TIME
echo 删除缓存
rm proot_proc tmp -rf
if grep -q 'ubuntu' "$sys_name-$AH/etc/os-release" ; then
    touch "$sys_name-$AH/root/.hushlogin"
fi

sleep $SLEEP_TIME

echo "写入启动脚本"
echo "为了兼容性考虑已将内核信息伪造成5.17.18-perf"

echo "正在安装 Node.js"

wget https://npmmirror.com/mirrors/node/v20.10.0/node-v20.10.0-linux-arm64.tar.xz
# 解压并删除 nodejs 源文件
tar -xvf node-v20.10.0-linux-arm64.tar.xz -C $sys_name-$AH/usr/local/
rm node-v20.10.0-linux-arm64.tar.xz -f
echo "export PATH=\$PATH:/usr/local/node-v20.10.0-linux-arm64/bin" >> $sys_name-$AH/etc/profile

echo "正在克隆 boilerplate"
git clone https://mirror.ghproxy.com/https://github.com/koishijs/boilerplate "$sys_name-$AH/root/boilerplate"

sleep $SLEEP_TIME
cat > $sys_name-$AH.sh <<- EOM
#!/bin/bash
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg  --bind=$sys_name-$AH/etc/proc/bus/pci/00:/proc/bus/pci/00 --bind=$sys_name-$AH/etc/proc/devices:/proc/bus/devices --bind=$sys_name-$AH/etc/proc/bus/input/devices:/proc/bus/input/devices --bind=$sys_name-$AH/etc/proc/modules:/proc/modules   --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/data/data/com.termux/files/usr/tmp:/tmp --bind=/data/data/com.termux/files:$sys_name-$AH/termux --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/su -l root
EOM

echo "授予启动脚本执行权限"
chmod +x $sys_name-$AH.sh
echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"


echo "#!/bin/bash
if ! command -v yarn &> /dev/null; then
    echo "正在安装 Yarn"
    export COREPACK_NPM_REGISTRY=https://registry.npmmirror.com
    corepack enable
fi
cd /root/boilerplate
yarn install
yarn start" > $sys_name-$AH/root/start.sh

echo "bash start.sh" >> $sys_name-$AH/root/.bashrc
echo "bash $sys_name-$AH.sh" > .bashrc
bash ./$sys_name-$AH.sh
