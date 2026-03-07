# Wir nutzen Node 22 (empfohlen für die neuesten Alphas)
FROM node:22-slim

# 1. System-Tools installieren (root-Rechte für ffmpeg/jq/curl/git)
USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    jq \
    curl \
    ffmpeg \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Arbeitsverzeichnis festlegen
WORKDIR /app

# 2. Den OFFIZIELLEN Code der Alpha-11 klonen
# Das ersetzt dein altes "COPY . ."
RUN git clone --depth 1 --branch v0.2.0-alpha.11 https://github.com/letta-ai/lettabot.git .

# 3. Bauen und systemweit verlinken
RUN npm install && \
    npm run build && \
    npm link

# 4. Den Bot starten
# Wir bleiben als root angemeldet, damit ffmpeg und die Dateisystem-Aktionen (MP3-Cache) reibungslos laufen.
CMD ["lettabot", "server"]
