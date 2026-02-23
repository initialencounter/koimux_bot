# Koishi 快速安装

在 Termux 上快速部署 Koishi。

## 安装 Koishi

依次执行以下内容：

```bash
pkg upgrade;
```

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/koishi.sh)"
```

## 常用命令

| 命令        | 说明        |
| ----------- | ----------- |
| `koi start` | 启动 Koishi |
| `koi stop`  | 停止 Koishi |
| `koi reset` | 重装 Koishi |

## 依赖安装

### FFmpeg

发送语音功能需要安装 FFmpeg：

```bash
pkg i ffmpeg -y
```

### Chromium

部分插件需要 Chromium 渲染图片：

```bash
pkg i x11-repo -y
pkg i tur-repo -y
pkg i chromium -y
```

### 完整安装

一键安装所有依赖：

```bash
pkg upgrade;
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/full.sh)"
```
