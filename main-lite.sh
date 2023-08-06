#!/usr/bin/bash
clear
sleep 1
echo 欢迎使用 KOIMUX_BOT 恢复包
sleep 1
echo 脚本问题联系QQ群399899914
sleep 1

function BOOT(){
	expect <(cat <<'EOD'
spawn bash centos-arm64.sh
expect "#"
send "bash lite.sh\n"
interact
EOD
)
}

function MAIN(){
input=$(whiptail --clear --title "koimux_bot一键脚本？" --menu "选择你需要进行的操作" 15 45 7 "1" "启动koishi" "0" "退出" 3>&1 1>&2 2>&3)
case $input in
1) echo "准备启动"
BOOT ;;
0) echo -e "\nexit"
sleep 1                           
exit 0 ;;                           
*) echo -"\nexit"
sleep 1                           
exit 0 ;;   
esac
}

MAIN