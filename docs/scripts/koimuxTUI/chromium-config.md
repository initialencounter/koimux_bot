# Termux 环境下 Koishi 使用 Chromium 配置指南

## 前置条件

如果你已经按照 [koimuxTUI.md](./koimuxTUI.md) 完成了依赖安装，那么 Chromium 应该已经安装完成。

## 验证 Chromium 安装

在 Termux 中执行以下命令验证：

```bash
chromium-browser --version
which chromium-browser
```

预期输出：

```bash
Chromium 144.0.7559.132
/data/data/com.termux/files/usr/bin/chromium-browser
```

## 安装 Koishi 插件

在 Koishi 插件市场中搜索并安装：

```bash
@shangxueink/koishi-plugin-puppeteer-without-canvas
```

## 配置插件

1. 在 Koishi 控制台中找到 `puppeteer-without-canvas` 插件
2. 配置 Chromium 可执行文件路径为：

   ```bash
   /data/data/com.termux/files/usr/bin/chromium-browser
   ```

3. 启用插件

## 完成

配置完成后，所有依赖 Puppeteer/Chromium 的 Koishi 插件（如截图、网页渲染等功能）都可以正常工作了。
