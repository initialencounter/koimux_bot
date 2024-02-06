# Koimux_bot

## 工具

* Android Linux 容器--[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)

## 一条龙脚本
包含安装 debian、nodejs、koishi，启动 koishi

注意！！！ 该脚本运行环境是 termux
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_debian.sh)"

# 备用脚本
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/tmp_patch.sh)"
```

## 下文所有命令只适用于在 proot 容器中运行

[如何安装并进入 proot 容器](./install_debian.md)

### 安装 nodejs 
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_nodejs.sh)"
```
### 安装 koishi

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_koishi.sh)"
```

### 重装 koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)"
```

### 启动 koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/start_koishi.sh)"
```


## 附录

### 安装 ffmpeg

发送语音可能需要安装该软件
```bash
apt update
apt install ffmpeg -y
```
### 安装 chromium

部分插件要使用 chromium 渲染图片
```bash
apt update
apt install chromium -y
```
