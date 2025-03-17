# 使用Node 20版本的基础镜像
FROM node:20.11.0

LABEL authors="陈明亮"

# 设置工作目录
WORKDIR /app

# 复制package.json和pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# 安装pnpm
RUN npm install -g pnpm

# 安装依赖
RUN pnpm install

# 复制项目文件
COPY . .

# 打包项目
RUN pnpm build:pro

# 暴露端口
EXPOSE 3001

# 启动应用
# CMD ["pnpm", "start"]
