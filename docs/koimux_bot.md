# Koimux_bot

## 使用教程

## 工具

* Android Linux容器--[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)

## 一条龙脚本
包含安装 linux容器, nodejs、koishi,启动 koishi
注意！！！ 该脚本运行环境是termux
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_debian.sh)"

# 备用脚本
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/tmp_patch.sh)"
```

# 下文所有命令只适用于在 proot 容器中运行

[如何安装并进入 proot 容器](./install_debian.md)

### 安装nodejs 
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_nodejs.sh)"
```
### 安装koishi

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_koishi.sh)"
```

### 重装koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)"
```

### 启动koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/start_koishi.sh)"
```


# 附录

### 安装ffmpeg

发送语言则需要安装该软件
```bash
apt update
apt install ffmpeg -y
```
### 安装chromium

部分插件要使用chromium渲染图片
```bash
apt update
apt install chromium -y
```
