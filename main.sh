#!/usr/bin/bash

AH=arm64

sleep 1

echo 欢迎使用KOIMUX一键脚本

sleep 1

echo 脚本问题联系QQ群399899914

sleep 1

echo 若安装出现错误

sleep 1

echo 可选择下载恢复包

sleep 1

echo 若出现登录qq失败,可选择修复登录失败

sleep 1

echo 正在安装依赖

apt update

apt install whiptail -y

function FIX_GOCQ(){

if [ -f "centos-arm64/root/koimux_bot/koishi.yml" ]; then

	#遍历当前目录中的accounts目录	for dir in $(ls -d centos-arm64/root/koimux_bot/accounts/*/); 

	do

	#获取device.json文件路径

	filepath=${dir}device.json

	#判断文件是否存在

	if [ -f $filepath ]; then

		#在json中替换字段值

		sed -i 's/"protocol":5/"protocol":2/g' $filepath

	fi

	done

else

	echo 修复失败,未安装koishi

	sleep 1

	MAIN

fi

}

function ONE_KEY(){

echo 正在安装依赖

apt install neofetch wget aria2 expect proot -y

echo "即将下载安装centos"

sys_name=centos

DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/centos/9-Stream/arm64/default/20230315_07%3A14/rootfs.tar.xz"

BAGNAME="rootfs.tar.xz"

mkdir $sys_name-$AH

if [ -e ${BAGNAME} ]; then

    tar xf rootfs.tar.xz -C $sys_name-$AH

else

	wget ${DEF_CUR}

	tar xf rootfs.tar.xz -C $sys_name-$AH

rm -rf ${BAGNAME}

echo -e "$sys_name-$AH 系统已下载，文件夹名为$sys_name-$AH"

fi

sleep 1

neofetch >>systeminfo.log

hostinfo=$(cat systeminfo.log |grep Host |awk -F':' '{print $2}')

echo "更新DNS"

sleep 1

echo "127.0.0.1 localhost" > $sys_name-$AH/etc/hosts

rm $sys_name-$AH/etc/hostname

echo "$hostinfo" > $sys_name-$AH/etc/hostname

echo "127.0.0.1 $hostinfo" > $sys_name-$AH/etc/hosts

rm -rf $sys_name-$AH/etc/resolv.conf &&

echo "nameserver 223.5.5.5

nameserver 223.6.6.6

nameserver 114.114.114.114" >$sys_name-$AH/etc/resolv.conf

echo "设置时区"

sleep 1

rm systeminfo.log

echo "export  TZ='Asia/Shanghai'" >> $sys_name-$AH/root/.bashrc

echo "export  TZ='Asia/Shanghai'" >> $sys_name-$AH/etc/profile

echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name-$AH/etc/profile

echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name-$AH/root/bashrc

echo 检测到你没有权限读取/proc内的所有文件

echo 将自动伪造新文件

mkdir proot_proc

aria2c -o proc.tar.xz -d ./proot_proc/ -x 16 https://gitee.com/yudezeng/proot_proc/raw/master/proc.tar.xz

sleep 1

mkdir tmp

echo 正在解压伪造文件

tar xJf proot_proc/proc.tar.xz -C tmp 

cp -r tmp/usr/local/etc/tmoe-linux/proot_proc tmp/

sleep 1

echo 复制文件

cp -r tmp/proot_proc $sys_name-$AH/etc/proc

sleep 1

echo 删除缓存

rm proot_proc tmp -rf

if grep -q 'ubuntu' "$sys_name-$AH/etc/os-release" ; then

    touch "$sys_name-$AH/root/.hushlogin"

fi

sleep 1

echo "写入启动脚本"

echo "为了兼容性考虑已将内核信息伪造成5.17.18-perf"

sleep 1

cat > $sys_name-$AH.sh <<- EOM

#!/bin/bash

pulseaudio --start

unset LD_PRELOAD

proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg  --bind=$sys_name-$AH/etc/proc/bus/pci/00:/proc/bus/pci/00 --bind=$sys_name-$AH/etc/proc/devices:/proc/bus/devices --bind=$sys_name-$AH/etc/proc/bus/input/devices:/proc/bus/input/devices --bind=$sys_name-$AH/etc/proc/modules:/proc/modules   --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/data/data/com.termux/files/usr/tmp:/tmp --bind=/data/data/com.termux/files:$sys_name-$AH/termux --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/su -l root

EOM

echo "授予启动脚本执行权限"

sleep 1

chmod +x $sys_name-$AH.sh

if [ -e ${PREFIX}/etc/bash.bashrc ]; then

	if ! grep -q 'pulseaudio' ${PREFIX}/etc/bash.bashrc; then

		sed -i "1i\pkill -9 pulseaudio" ${PREFIX}/etc/bash.bashrc

	fi

else

	sed -i "1i\pkill -9 pulseaudio" $sys_name-$AH.sh

fi

echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"

sleep 1

expect <(cat <<'EOD'

spawn echo "即将下载安装koishi"

spawn bash centos-arm64.sh

expect "#"

send "ls\n"

send "yum upgrade -y\n"

send "yum install git -y\n"

send "git clone https://gitee.com/initencunter/koimux_bot\n"

send "yum install npm -y\n"

send "npm i -g yarn\n"

send "cd koimux_bot\n"

send "yarn\n"

send "yarn start\n"

interact

EOD

)

}

function RE_INSTALL_BOT(){

expect <(cat <<'EOD'

spawn bash centos-arm64.sh

expect "#"

send "rm -rf koimux_bot\n"

send "git clone https://gitee.com/initencunter/koimux_bot\n"

send "yum install npm -y\n"

send "npm i -g yarn\n"

send "cd koimux_bot\n"

send "yarn\n"

send "yarn start\n"

interact

EOD

)

}

function RECOVER(){

echo 将在3秒后下载

sleep 1

echo 将在2秒后下载

sleep 1

echo 将在1秒后下载

sleep 1

pkg i wget -y

cd ~ 

cd ~

cd /sdcard/xinhao/data

wget https://github.com/initialencounter/koimux_bot/releases/download/ZeroTermux备份恢复包/koimux_v1.0.tar.gz

cd ~

cd ~

}

function BOOT(){

if [ -f "centos-arm64/root/koimux_bot/koishi.yml" ]; then

	echo 正在启动koishi

expect <(cat <<'EOD'

spawn bash centos-arm64.sh

expect "#"

send "cd koimux_bot\n"

send "yarn start\n"

interact

EOD

)

else

	echo 启动失败,未安装koishi

	sleep 1

	MAIN

fi

}

function MAIN(){

input=$(whiptail --clear --title "koimux_bot一键脚本？" --menu "选择你需要进行的操作" 15 45 7 "1" "启动koishi" "2" "安装centos+koishi并启动" "3" "重装koishi,不卸载centos" "4" "彻底删除centos+koishi" "5" "修复登录失败，密码错误或被冻结" "6" "下载恢复包" "0" "退出" 3>&1 1>&2 2>&3)

case $input in

1) echo "准备启动"

BOOT ;;

2) echo "准备安装centos+koishi"        

ONE_KEY ;;

3) echo "准备重装koishi,不卸载centos"

RE_INSTALL_BOT ;;

4) echo "准备彻底删除centos+koishi"

rm -rf centos-arm64 

MAIN ;;

5) echo "开始修复GOCQ"

FIX_GOCQ

echo "已修复"

MAIN ;;

6) echo "开始下载koimux_v1.0.tar.gz"

RECOVER

echo "已下载koimux_v1.0.tar.gz，请打开左侧菜单，恢复容器"

exit 0 ;;

0) echo -e "\nexit"

sleep 1                           

exit 0 ;;                           

*) echo -"\nexit"

sleep 1                           

exit 0 ;;   

esac

}

MAIN
