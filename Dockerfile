# Multi-stage Node (generic) - adjust start script / build output as needed
FROM node:18-alpine AS builder
WORKDIR /app


COPY package*.json ./
RUN npm ci

# Copy source and build (if your project builds)
COPY . .

# Production image
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/package*.json ./
RUN npm ci --only=production


COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "start"]
