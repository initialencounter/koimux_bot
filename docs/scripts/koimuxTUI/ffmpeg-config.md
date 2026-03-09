# Termux 环境下 Koishi 使用 FFmpeg 配置指南

## 前置条件

如果你已经按照 [koimuxTUI.md](./koimuxTUI.md) 完成了**依赖安装**，那么 FFmpeg 应该已经安装完成。

## 验证 FFmpeg 安装

在 Termux 中执行以下命令验证：

```bash
which ffmpeg
```

预期输出：

```bash
/data/data/com.termux/files/usr/bin/ffmpeg
```

## 安装 Koishi 插件

在 Koishi 插件市场中搜索并安装：

```bash
koishi-plugin-ffmpeg-path
```

## 配置插件

1. 在 Koishi 控制台中找到 `ffmpeg-path` 插件
2. 配置 FFmpeg 路径为：

   ```bash
   /data/data/com.termux/files/usr/bin/ffmpeg
   ```

3. 启用插件

## 完成

配置完成后，所有依赖 FFmpeg 的 Koishi 插件都可以正常工作了。
