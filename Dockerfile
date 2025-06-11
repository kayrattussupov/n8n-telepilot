FROM n8nio/n8n:latest

USER root

# Обновление системы и установка всех необходимых зависимостей
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    build-essential \
    make \
    g++ \
    gcc \
    libc6-dev \
    libffi-dev \
    libssl-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Создание символических ссылок для Python
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

# Обновление npm до последней версии
RUN npm install -g npm@latest

# Установка node-gyp глобально
RUN npm install -g node-gyp

# Настройка npm для использования правильного Python
RUN npm config set python /usr/bin/python3

# Установка TelePilot с расширенными опциями
RUN npm install -g @telecopilotco/n8n-nodes-telepilot --unsafe-perm --build-from-source

USER node

EXPOSE 5678

CMD ["n8n"]
