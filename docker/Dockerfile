FROM node:lts-alpine

RUN apk update

# 安装 chromium 及要用到的工具
RUN apk add -f chromium ffmpeg git wget

# 克隆koishi-bp
RUN git clone https://github.com/koishijs/boilerplate

# 修改端口
RUN sed -i 's/port: 5140/port: 7860/g' /boilerplate/koishi.yml

# 避免 go-cqhttp 安装失败
RUN mkdir /.local
RUN chmod -R 777 /.local

# 安装依赖
RUN cd /boilerplate; corepack enable; yarn install

# 修改权限防止抱错
RUN chmod -R 777 /boilerplate

# 设置工作目录
WORKDIR "/boilerplate"

# 设置启动命令
CMD ["yarn", "start"]