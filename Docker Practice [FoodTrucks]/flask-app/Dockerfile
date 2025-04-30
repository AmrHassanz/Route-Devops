# Stage 1: Build frontend assets using Node
FROM node:10.20.1 as frontend-builder

WORKDIR /build

# Copy frontend source files (if any)
COPY . ./frontend/

WORKDIR /build/frontend

# Install dependencies and build (adjust if you're not using any frontend framework)
RUN npm install && npm run build

# Stage 2: Set up Python 3 environment for Flask with pip3
FROM python:3.7-slim

# Set working directory
WORKDIR /app

# Copy Python requirements and install them using pip3
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy Flask app
COPY . ./app

# Copy built frontend assets if needed by Flask
COPY --from=frontend-builder /build/frontend/static/build ./app/static/

# Expose Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python3", "app/app.py"]
