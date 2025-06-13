# Используем Ubuntu 22.04 для совместимости с современными библиотеками
FROM ubuntu:22.04

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Создаем пользователя для n8n
RUN useradd -m -s /bin/bash n8n

# Переключаемся на пользователя n8n
USER n8n
WORKDIR /home/n8n

# Устанавливаем n8n глобально
RUN npm install -g n8n

# Создаем директории для n8n
RUN mkdir -p /home/n8n/.n8n/nodes

# Устанавливаем Telepilot
RUN cd /home/n8n/.n8n/nodes && npm install @telepilotco/n8n-nodes-telepilot

# Настраиваем переменные окружения
ENV N8N_USER_FOLDER=/home/n8n/.n8n
ENV N8N_BASIC_AUTH_ACTIVE=false
ENV EXECUTIONS_PROCESS=main

EXPOSE 5678

CMD ["n8n", "start"]
