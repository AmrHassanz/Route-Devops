# FROM nginx:alpine
FROM nginx:stable-alpine3.21-perl

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# -g daemon off : to run nginx in the foreground and give it PID 1 so the container don't stop
CMD ["nginx", "-g", "daemon off;"]