# 动态更新模式 Dockerfile
FROM node:20-alpine

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

# 安装项目依赖
COPY package*.json ./
RUN npm install --production && npm cache clean --force

# 复制整个项目
COPY . .

# 监听文件变化，自动生成
CMD ["sh", "-c", "npm hexo generate --watch & npm hexo server -l 0.0.0.0"]
