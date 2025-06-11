FROM n8nio/n8n:latest

USER root

# Установка Python и зависимостей для TelePilot
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    build-essential \
    make \
    g++ \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Создание символических ссылок
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Установка TelePilot community node
RUN npm install -g @telecopilotco/n8n-nodes-telepilot

USER node

EXPOSE 5678

CMD ["n8n"]
