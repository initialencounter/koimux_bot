# Koimux_bot-qsign

## 使用教程

## 工具

* Android Linux容器--[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)

## 一条龙脚本
包含安装 linux容器, nodejs、koishi、jdk、qsign,启动 koishi 和 qsign
注意！！！ 该脚本运行环境是termux, 运行该脚本前请先运行命令`pkg upgrade`升级 termux
```shell
pkg upgrade;
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_debian.sh)"
```

# 下文所有命令只适用于 proot容器 Debian-10 和CentOS-7 中运行

[如何安装并进入 proot 容器](./install_debian.md)

### 安装nodejs 
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_nodejs.sh)"
```
### 安装java
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_jdk.sh)"
```
### 安装koishi

```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/install_koishi.sh)"
```

### 重装koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/re_install_koishi.sh)"
```

### 安装qsign
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/setup_qsign.sh)"
```

### 启动qsign
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/start_qsign.sh)"
```

### 启动koishi
```bash
bash -c "$(curl -L https://gitee.com/initencunter/koimux_bot/raw/master/script/start_koishi.sh)"
```


# 附录

### 安装ffmpeg

发送语言则需要安装该软件
```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="yum" label="CentOS" default>
yum install ffmpeg -y
  </TabItem>
  <TabItem value="apt" label="Deb">
apt install ffmpeg -y
  </TabItem>
</Tabs>

```
### 安装chromium

部分插件要使用chromium渲染图片
```mdx-code-block
<Tabs>
  <TabItem value="yum" label="CentOS" default>
yum install chromium -y
  </TabItem>
  <TabItem value="apt" label="Deb">
apt install chromium -y
  </TabItem>
</Tabs>
```