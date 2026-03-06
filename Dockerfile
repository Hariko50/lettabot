FROM node:20-slim
WORKDIR /app
COPY . .
RUN npm install && npm run build && npm link
CMD ["lettabot", "server"]
