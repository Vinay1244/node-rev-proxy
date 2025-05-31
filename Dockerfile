# ---- Build React Frontend ----
FROM node:18 AS client-builder
WORKDIR /app
COPY src/client/ ./client
COPY webpack.config.js ./
COPY package.json ./
COPY . .
RUN npm install && npm run build

# ---- Backend with Node.js ----
FROM node:18-alpine AS backend
WORKDIR /app
COPY src/server/ ./server
COPY package.json ./
RUN npm install
COPY --from=client-builder /app/dist ./dist
EXPOSE 5000
CMD ["node", "server/index.js"]

