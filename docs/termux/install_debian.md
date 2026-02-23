# Termux 安装 Debian 容器

Termux 存在许多限制，如无法安装某些软件包。

proot 容器可以帮助我们绕过这些限制。

## 方法一：使用自带工具（推荐）

| 步骤        | 操作                                                          |
| ----------- | ------------------------------------------------------------- |
| 1. 打开工具 | 音量上键 → 左侧菜单栏（第五个）→ 发行版本 → 最新版本          |
| 2. 选择版本 | proot容器 → 安装arm64 Linux系统 → debian → debian 10 (buster) |
| 3. 开始安装 | 等待安装完成                                                  |
| 4. 安装完成 | 打开 yti tools → 选择"不用"                                   |

### 启动容器

```bash
bash ~/buster-arm64.sh
```

## 方法二：使用 tmoe 安装

### 1. 运行安装脚本

```bash
bash -c "$(curl -L https://gitee.com/mo2/linux/raw/2/2)"
```

### 2. 配置镜像源

![更改镜像源](../assets/termux/6.png)

---

![选择镜像](../assets/termux/7.png)

---

![确认切换](../assets/termux/8.png)

---

切换镜像源时输入 `y`，然后回车。

![输入确认](../assets/termux/9.png)

---

### 3. 选择语言

![选择语言](../assets/termux/10.png)

---

选择 proot 容器。

![克隆项目](../assets/termux/11.png)

---

回车继续。

![换镜像源](../assets/termux/12.png)

---

输入 `y`，回车。

![修改完成](../assets/termux/13.png)

---

### 4. 主题设置

| 设置项   | 说明                       |
| -------- | -------------------------- |
| 终端配色 | 选择喜欢的配色方案，可跳过 |
| 字体加粗 | 选择字体样式，可跳过       |
| 虚拟键盘 | 不建议修改默认布局         |

![终端配色](../assets/termux/14.png)

---

![字体设置](../assets/termux/15.png)

---

![键盘布局](../assets/termux/16.png)

---

### 5. DNS 和时区设置

![DNS设置](../assets/termux/17.png)

---

设置 DNS，选择任意一个即可。

![回车返回](../assets/termux/18.png)

---

![一言功能](../assets/termux/19.png)

---

启用一言功能（可选）。

![时区设置](../assets/termux/20.png)

---

设置时区为上海，选择 `yes`。

### 6. 挂载目录

![挂载目录](../assets/termux/21.png)

---

![挂载确认](../assets/termux/22.png)

---

挂载目录后，文件操作更加方便。

![认可协议](../assets/termux/23.png)

---

同意协议继续。

### 7. 选择发行版

![容器操作](../assets/termux/24.png)

---

选择 arm64 容器发行版本列表。

![容器列表](../assets/termux/25.png)

---

选择 Debian。

![选择版本](../assets/termux/26.png)

---

建议选择 stable 10-buster。

![启动proot](../assets/termux/27.png)

---

选择启动 proot，回车。

### 8. 安装容器

![开始安装](../assets/termux/28.png)

---

回车开始安装。

![sudo设置](../assets/termux/29.png)

---

sudo 用户基本用不到，可跳过。

![终端美化](../assets/termux/30.png)

---

可跳过。

![退出安装](../assets/termux/31.png)

---

### 9. 启动和退出

![安装完成](../assets/termux/32.png)

---

安装完成后，输入 `exit` 退出 proot 容器。

下次启动只需输入：

```bash
debian
```

![容器管理](../assets/termux/33.png)

---
