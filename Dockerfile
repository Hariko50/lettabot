FROM node:20-slim
WORKDIR /app
COPY . .
RUN npm install && npm run build && npm link
CMD ["lettabot", "server"]
RUN apt-get update && apt-get install -y ffmpeg
