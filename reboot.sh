#!/bin/bash

# 启动zowo
screen -dmS ks
screen -S ks -p 0 -X stuff "cd /root/zowo; yarn start$(printf \\r)"
screen -dmS gocq
screen -S gocq -p 0 -X stuff "cd /root/zowo/gocq; ./go-cqhttp$(printf \\r)"
# 启动edu_bot
screen -dmS ks1
screen -S ks1 -p 0 -X stuff "cd /root/edu_bot; yarn start$(printf \\r)"
screen -dmS gocq1
screen -S gocq1 -p 0 -X stuff "cd /root/edu_bot/gocq$(printf \\r)"
# 启动chatgpt
screen -dmS ks2
screen -S ks2 -p 0 -X stuff "cd /root/koimux_bot; yarn start$(printf \\r)"
screen -dmS gocq2
screen -S gocq2 -p 0 -X stuff "cd /root/koimux_bot/gocq; ./go-cqhttp$(printf \\r)"
