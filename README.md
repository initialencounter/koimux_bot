# Koishi 模板仓库

本仓库包含了 Koishi 的模板项目。

## 使用教程

<https://koishi.chat/manual/starter/boilerplate.html>
## 工具

* Android Linux容器--[ZeroTermux](https://od.ixcmstudio.cn/repository/main/ZeroTermux/)

* QQ扫码工具--[Tim](https://tim.qq.com/mobile/index.html?adtag=index)

## 1.安装proot容器

### 1.1更新包管理器

```

pkg upgrade

```

### 1.2安装CentOS

左侧菜单栏--发行版本--最新版本--proot容器--CentOS

## 2.启动CentOS

<a name="a"></a>

打开ZeroTermux输入：

```

./centos-arm64.sh

```

## 3. 安装依赖

### 3.1 升级包管理器yum

```

yum upgrade

```

### 3.2克隆项目

```

git clone https://github.com/initialencounter/koimux_bot

```

### 3.2 安装yarn

```

yum install npm -y

```

```

npm i -g yarn

```

### 3.3安装依赖

```

cd koimux

```

```

yarn

```

## 4.启动机器人

### 4.1启动项目

```

yarn start

```

### 4.2 打开控制台

打开浏览器输入地址

```

localhost:5140

```

或

```

127.0.0.1:5140

```

### 接入QQ

进入插件设置

点击onebot

输入机器人QQ账号

勾选自动创建go cqhttp自进程

右上角启用插件

等待出现二维码-->截图使用tim扫码

返回Termux

Ctrl+c结束项目

修改device.json

使用vi将device.json里的 "protocol":5 改成 "protocol":2

重新启动

扫码登录

### 配置davinci-003插件

打开控制台

插件管理

选择davinci-003插件

填写api_key

启用插件
