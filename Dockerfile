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
RUN cd .medusa/server 
RUN npm install && npm run predeploy

RUN cd .medusa/server 

# Start the Medusa server in production mode
CMD ["npm", "run", "start"]