# 使用Node 20版本的基础镜像
FROM node:20 as build-stage

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
RUN pnpm run build:pro

# 第二阶段：使用 Nginx 部署 Vue 应用
FROM nginx:latest as production-stage
COPY --from=build-stage /app/dist /etc/nginx/html/geeker
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
