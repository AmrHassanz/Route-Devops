# Build stage
FROM node:lts-alpine3.21 as build
# FROM node:18-alpine as build

WORKDIR /app

# Copy package files first for better caching
COPY package.json ./

# Install dependencies
RUN npm install

# Copy all other files
COPY . .

# Build the app
RUN npm run build

# Production stage
# FROM nginx:alpine
FROM nginx:stable-alpine3.21-perl

# Copy build files
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# -g daemon off : to run nginx in the foreground and give it PID 1 so the container don't stop
CMD ["nginx", "-g", "daemon off;"]