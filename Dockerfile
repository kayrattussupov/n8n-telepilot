FROM node:18-bullseye

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Установка n8n и TelePilot
RUN npm install -g n8n@latest
RUN npm install -g @telecopilotco/n8n-nodes-telepilot

# Настройка пользователя
RUN groupadd -r n8n && useradd -r -g n8n -d /home/n8n n8n
RUN mkdir -p /home/n8n/.n8n && chown -R n8n:n8n /home/n8n

USER n8n
WORKDIR /home/n8n

ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

EXPOSE 5678
CMD ["n8n"]
