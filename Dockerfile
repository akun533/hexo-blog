# 动态更新模式 Dockerfile
FROM node:20-alpine

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

# 安装项目依赖
COPY package*.json ./
RUN npm install --production && npm cache clean --force

# 复制整个项目
COPY . .

# 使用默认用户运行
CMD ["sh", "-c", "node -v && npm -v && echo 'Application ready'"]
