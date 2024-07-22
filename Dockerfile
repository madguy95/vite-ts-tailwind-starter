# Stage 1: Build stage
FROM node:lts-alpine as build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire project and build the Vue.js application with Vite
COPY . .
RUN npm run build-only

# Stage 2: Production stage
FROM nginx:alpine

# Copy the built application from the build stage to the nginx public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
