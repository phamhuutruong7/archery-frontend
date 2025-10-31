# Multi-stage build for Vue 3 + Vuetify frontend
# Stage 1: Build the application
FROM node:20-alpine AS build-stage

# Set working directory
WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine AS production-stage

# Copy built application from build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]