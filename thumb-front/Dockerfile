# syntax=docker/dockerfile:1

# ---------- 构建阶段：安装依赖并生成静态资源 ----------
FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json ./

# 国内网络默认走 npmmirror，可用 --build-arg NPM_REGISTRY=https://registry.npmjs.org 切回官方
ARG NPM_REGISTRY=https://registry.npmmirror.com
RUN npm config set registry ${NPM_REGISTRY} \
    && npm ci --no-audit --no-fund

COPY . .
RUN npm run build

# ---------- 运行阶段：Nginx 托管静态文件并反代 /api ----------
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
