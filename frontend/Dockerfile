# === Stage 1: Build the application ===
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source files
COPY . .
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL
# Build the Next.js app
RUN npm run build

# === Stage 2: Run the application ===
FROM node:18-alpine AS runner

# Set working directory
WORKDIR /app

# Reinstall only production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy the built app from the builder stage
COPY --from=builder /app/.next .next
# COPY --from=builder /app/public public
# COPY --from=builder /app/next.config.js ./
#COPY --from=builder /app/.env.local .env.local

# Expose the port Next.js runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]