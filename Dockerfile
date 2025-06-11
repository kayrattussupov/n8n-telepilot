FROM node:18-bullseye

# Установка n8n
RUN npm install -g n8n@latest

# Python уже есть в node:18-bullseye образе
# Установка дополнительных build зависимостей
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка TelePilot
RUN npm install -g @telecopilotco/n8n-nodes-telepilot

# Создание пользователя n8n
RUN groupadd -r n8n && useradd -r -g n8n -d /home/n8n -s /bin/bash n8n
RUN mkdir -p /home/n8n && chown -R n8n:n8n /home/n8n

USER n8n
WORKDIR /home/n8n

EXPOSE 5678

CMD ["n8n"]
