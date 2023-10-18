#!/bin/bash

# 启动koishi
screen -dmS ks
screen -S ks -p 0 -X stuff "cd /root/koimux_boot; yarn start$(printf \\r)"
