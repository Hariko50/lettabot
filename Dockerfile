FROM node:20-slim

# Wir brauchen root-Rechte für die Installation von ffmpeg
USER root

WORKDIR /app

# System-Tools für TTS installieren
USER root
RUN apt-get update && apt-get install -y \
    jq \
    curl \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*
USER node

# 2. Projektdateien kopieren
COPY . .

# 3. App bauen und verlinken
RUN npm install && npm run build && npm link

# 4. Den Bot starten (DAS MUSS GANZ UNTEN STEHEN)
CMD ["lettabot", "server"]
