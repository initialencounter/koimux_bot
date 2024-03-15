# Koimux_bot

在手机上部署 Koishi

## 工具

* 基于 Termux 二次开发的 Android 终端应用程序和 Linux 环境。[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)

### 安装 koishi

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/koishi.sh)"
```

### 重装 koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)"
```

### 启动 koishi
```bash
koishi
```


## 附录

### 安装 ffmpeg

发送语音可能需要安装该软件
```bash
pkg i ffmpeg -y
```
### 安装 chromium

部分插件要使用 chromium 渲染图片
```bash
pkg i x11-repo -y
pkg rei tur-repo -y
pkg i chromium -y
```

### 我全都要

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/full.sh)"
```