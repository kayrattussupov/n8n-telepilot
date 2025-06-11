FROM n8nio/n8n:latest

USER root

# Установка Python и зависимостей
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3 /usr/bin/python

# Установка TelePilot
RUN npm install -g @telecopilotco/n8n-nodes-telepilot

USER node

EXPOSE 5678

CMD ["n8n"]
