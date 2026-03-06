FROM node:20-slim

# Wir brauchen root-Rechte für die Installation von ffmpeg
USER root

WORKDIR /app

# 1. System-Abhängigkeiten installieren (ffmpeg)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 2. Projektdateien kopieren
COPY . .

# 3. App bauen und verlinken
RUN npm install && npm run build && npm link

# 4. Den Bot starten (DAS MUSS GANZ UNTEN STEHEN)
CMD ["lettabot", "server"]
