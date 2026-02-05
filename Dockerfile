FROM node:20-alpine

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

COPY package*.json ./
RUN npm install

COPY . .

# 全局安装 hexo 命令行工具
RUN npm install -g hexo hexo-server --omit=dev && npm cache clean --force

EXPOSE 4000

CMD ["npx", "hexo", "server", "--watch"]

