FROM node:22-slim

USER root

# 1. System-Tools und SSL-Zertifikate installieren
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    jq \
    curl \
    ffmpeg \
    git && \
    update-ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. Den Code aus dem reparierten Main-Branch klonen
RUN git clone --depth 1 --branch main https://github.com/letta-ai/lettabot.git .

# 3. DEINE lettabot.yaml in den Container kopieren
# Das muss hier stehen, damit git clone nicht blockiert wird!
COPY lettabot.yaml /app/lettabot.yaml

# 4. Bauen und verlinken
RUN npm install && \
    npm run build && \
    npm link

# 5. Den Bot starten
CMD ["lettabot", "server"]
