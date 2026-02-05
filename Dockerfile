# 动态更新模式 Dockerfile
FROM node:20-alpine

WORKDIR /app

# 创建非root用户
RUN addgroup -S hexo && adduser -S hexo -G hexo && \
    mkdir -p /app/source && chown -R hexo:hexo /app

RUN npm config set registry https://registry.npmmirror.com/

# 全局安装 hexo 命令行工具
RUN npm install -g hexo hexo-server --omit=dev && npm cache clean --force

# 安装项目依赖
COPY package*.json ./
RUN npm install --production && npm cache clean --force

# 复制整个项目
COPY . .

# 设置权限
RUN chown -R hexo:hexo /app

USER hexo

# 监听文件变化，自动生成
CMD ["sh", "-c", "hexo generate --watch & hexo server -l 0.0.0.0"]
# 使用默认用户运行
CMD ["sh", "-c", "node -v && npm -v && echo 'Application ready'"]

