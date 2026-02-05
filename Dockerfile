FROM node:20-alpine

WORKDIR /app

RUN npm config set registry https://registry.npmmirror.com/

# 全局安装 hexo 命令行工具
RUN npm install -g hexo hexo-server --omit=dev && npm cache clean --force

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 4000

CMD ["npx", "hexo", "server", "--watch"]
