# Используем официальный образ n8n как базу
FROM n8nio/n8n:latest

# Переключаемся на root для установки системных пакетов
USER root

# Обновляем системные библиотеки для совместимости с Telepilot
RUN apk add --no-cache \
    libc6-compat \
    gcompat \
    libstdc++

# Создаем директории и настраиваем права
RUN mkdir -p /home/node/.n8n/nodes && \
    chown -R node:node /home/node/.n8n

# Переключаемся обратно на пользователя node
USER node

# Устанавливаем Telepilot в правильную директорию
RUN cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot --no-optional --production

# Настраиваем переменные окружения
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_BASIC_AUTH_ACTIVE=false
ENV EXECUTIONS_PROCESS=main
ENV N8N_SECURE_COOKIE=false

EXPOSE 5678

# Используем исходную точку входа n8n
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
