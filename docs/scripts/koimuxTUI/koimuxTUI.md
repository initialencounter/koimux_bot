# Koishi Manager for Termux

这是一个用于在 Termux 上管理 Koishi 实例的脚本工具。

通过这个工具，你可以轻松安装依赖、创建和管理 Koishi 实例。

## 快速开始

使用以下指令运行脚本：

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/koimuxTUI.sh)"
```

或使用 GitHub 源：

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/koishi-shangxue-plugins/koishi-shangxue-apps/main/scripts/termux/koimuxTUI.sh)"
```

## 推荐环境

建议使用 **Zero Termux**，它提供了更好的 Termux 体验和快捷功能。

- [Zero Termux - 镜像下载](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)
- [Zero Termux - GitHub 发布页](https://github.com/hanxinhao000/ZeroTermux/releases)

## 初始设置

### 1. 切换源

- 打开 Zero Termux
- 按【音量上键】，进入 Zero Termux 快捷交互菜单
- 依次点击【常用功能】→【切换源】→【清华源】

> 如果遇到确认对话框，点击【确认】

![切换清华源](../assets/koimuxTUI/2026-02-23_17-53-24.png)

### 2. 更新包管理器

切换完清华源后，

在 Termux 中运行以下命令：

```bash
pkg update -y
```

> 如果遇到确认步骤，请输入 `Y` ，并回车确认

### 3. 安装 Koishi Manager

运行以下命令 下载并运行脚本：

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/koimuxTUI.sh)"
```

## 使用步骤

### 1. 安装依赖

- 在脚本的主菜单中，选择【1 安装依赖】
- 依次安装所有依赖项（x11-repo、tur-repo、libexpat、chromium、ffmpeg、nodejs 等）

::: warning 注意
此步骤需要科学上网！
:::

- 安装完依赖后，选择【7 返回主菜单】

### 2. 创建 Koishi 实例

- 在主菜单中，选择【2 创建 Koishi 实例】
- 推荐小白用户一路回车，使用默认选项
- 完成创建后，Koishi 会自动启动，并在浏览器中打开 Web UI

::: tip 提示
除非你需要多开实例，否则不要修改默认选项。

如果多开实例，请确保实例目录名称唯一。

例如，如果已经创建了`koishi-app`，再次创建koishi实例时，请务必使用其他项目名称，例如 `koishi-app2`，否则会导致数据被覆盖而丢失！
:::

### 3. 实例目录

- Koishi 实例默认存储在 `~/koishi/*/` 目录下
- 默认实例目录为 `~/koishi/koishi-app/`

## 备份与恢复

### 首次创建后务必备份

#### 1. 结束所有进程

多次按下 `Ctrl + C`，确保所有 Koishi 进程已结束。

::: details 如何按下 Ctrl + C？
点击 ZeroTermux 底部的 `Ctrl` 按钮为高亮状态，然后键盘键入 `C`，即可。
:::

#### 2. 备份实例

- 按音量上键，进入 Zero Termux 快捷交互菜单
- 依次选择【备份/恢复】→【tar.gz】→【确定】

## 再次启动 Koishi

### 1. 运行脚本

运行以下命令：

```bash
koimux
```

### 2. 管理实例

- 在主菜单中，选择【3 管理 Koishi 实例】
- 选择对应的实例名称
- 选择【1 启动 Koishi (yarn start)】

## 注意事项

- **确保网络畅通**：安装依赖和创建实例时需要联网
- **备份数据**：定期备份 Koishi 实例，防止数据丢失
- **多开实例**：如果需要多开实例，请确保实例目录名称唯一

## 反馈与支持

如果遇到问题，请截图完整日志并反馈至项目仓库：

- [GitHub Issues](https://github.com/shangxueink/koimux_bot/issues)
