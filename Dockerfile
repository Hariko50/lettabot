FROM node:20-slim

# 1. System-Tools als root installieren
USER root

# Installation mit Sicherheits-Flags für Docker
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    jq \
    curl \
    ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Arbeitsverzeichnis festlegen
WORKDIR /app

# 2. Projektdateien kopieren
# Wir kopieren alles als root, damit die Berechtigungen für npm link passen
COPY . .

# 3. Abhängigkeiten installieren, bauen und verlinken
# Wir führen dies als root aus, damit 'npm link' die Symlinks im System setzen kann
RUN npm install && \
    npm run build && \
    npm link

# 4. Den Bot starten
# Wir lassen den Prozess als root laufen, damit der Bot 
# uneingeschränkt MP3-Dateien zwischenspeichern und konvertieren kann.
CMD ["lettabot", "server"]
