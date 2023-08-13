if uname -a | grep -q "Android"; then
    echo "运行环境正确"
else
    echo "您的会话正处于 proot 容器内"
    exit 1
fi


echo "即将下载安装centos"
sys_name=centos
AH="arm64"
BAGNAME="rootfs.tar.xz"
DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/centos/9-Stream/arm64/default/20230809_07%3A08/rootfs.tar.xz"


# 检测是否安装过
if [ -f "$sys_name-$AH/root/.bashrc" ]; then
    echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"
    exit 1
else
    echo 正在安装依赖
fi

pkg install neofetch wget aria2 expect proot -y
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

curl -O https://gitee.com/initencunter/koimux_bot/raw/master/script/all.sh
mv all.sh $sys_name-$AH/root/start.sh
echo "bash start.sh" >> $sys_name-$AH/root/.bashrc
bash ./$sys_name-$AH.sh