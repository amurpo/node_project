# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production
FROM node:20-alpine AS final
RUN addgroup -S nodeuser && adduser -S -G nodeuser nodeuser
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY app.js ./
COPY views ./views
COPY package*.json ./
RUN chown -R nodeuser:nodeuser /usr/src/app
USER nodeuser
EXPOSE 8080
ENV NODE_ENV=production
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD wget --spider http://localhost:8080 || exit 1
CMD ["node", "app.js"]
