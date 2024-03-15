# Koimux_bot

在手机上部署 Koishi

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
koi start
```
### 停止 koishi
```bash
koi stop
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

## 参考与基础

[koishi](https://github.com/koishijs/koishi)

[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)