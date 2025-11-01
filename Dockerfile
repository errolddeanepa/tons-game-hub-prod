# Dockerfile for Render.com web service
FROM node:20-alpine

WORKDIR /app
# Install project dependencies (cache-friendly)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build Medusa production bundle
RUN npx medusa build

# Install dependencies in the build output directory & Run migrations before starting the server
ENV NODE_ENV=production
ENV PORT=9000
EXPOSE 9000

# Start the Medusa server in production mode
CMD ["npm", "run", "dev"]