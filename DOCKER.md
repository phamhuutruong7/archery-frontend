# 🐳 Docker Setup Guide

This guide will help you run the Archery Frontend application using Docker.

## Prerequisites

- Docker Desktop (Windows/macOS) or Docker Engine (Linux)
- Docker Compose (usually included with Docker Desktop)

## 🚀 Quick Start

### Development Mode
```bash
# Start development server with hot reload
npm run docker:dev

# Or manually with docker-compose
docker-compose up archery-frontend-dev
```

### Production Mode
```bash
# Build and start production server
npm run docker:prod

# Or manually with docker-compose
docker-compose --profile production up archery-frontend-prod
```

## 📋 Available Docker Commands

| Command | Description |
|---------|-------------|
| `npm run docker:dev` | Start development server with hot reload |
| `npm run docker:build` | Build production Docker image |
| `npm run docker:build-dev` | Build development Docker image |
| `npm run docker:prod` | Start production server |
| `npm run docker:stop` | Stop all Docker containers |

## 🏗️ Docker Configuration

### Dockerfile (Production)
- **Multi-stage build** for optimized image size
- **Nginx** for serving static files
- **Alpine Linux** for minimal footprint
- **Security headers** and caching configuration

### Dockerfile.dev (Development)
- **Hot reload** support with volume mounting
- **Non-root user** for security
- **Signal handling** with dumb-init

### docker-compose.yml
- **Development profile** (default): Hot reload, volume mounting
- **Production profile**: Optimized for deployment

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the project root:

```bash
# API Configuration
VITE_API_URL=http://localhost:5000

# Development Configuration
NODE_ENV=development
```

### Port Configuration
- **Development**: http://localhost:3000
- **Production**: http://localhost:80

## 🐛 Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   # Change ports in docker-compose.yml
   ports:
     - "3001:3000"  # Use different host port
   ```

2. **Permission issues (Linux)**
   ```bash
   # Fix file permissions
   sudo chown -R $USER:$USER .
   ```

3. **Hot reload not working**
   - Ensure volume mounting is configured correctly
   - Check that `usePolling: true` is set in vite.config.mts

### Useful Docker Commands

```bash
# View running containers
docker ps

# View logs
docker-compose logs archery-frontend-dev

# Clean up containers and images
docker-compose down
docker system prune -f

# Rebuild containers
docker-compose up --build
```

## 🚀 Deployment

For production deployment, use the production Dockerfile:

```bash
# Build production image
docker build -t archery-frontend:latest .

# Run production container
docker run -p 80:80 archery-frontend:latest
```

## 🔗 Next Steps

- Set up backend API with Docker
- Configure reverse proxy (Nginx/Traefik)
- Add SSL/HTTPS configuration
- Set up CI/CD pipeline with GitHub Actions