# Lab 06 Docker

This project demonstrates the use of Docker Compose to manage multi-container Docker applications.
- Nginx as a reverse proxy
- FastAPI for the backend API
- Redis for caching
- PostgreSQL as the relational database

## Prerequisites

- Docker installed on your system.

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/AmrHassanz/Route-Devops.git
    ```

2. Build and start the containers:
    ```bash
    docker-compose up
    ```

3. Access the application:
    - Check the logs to find the running services and their ports:
      ```bash
      docker-compose ps
      ```
    - Open your browser and navigate to the appropriate service URL.

## Stopping the Containers

To stop the running containers, use:
```bash
docker-compose down
```

## Project Structure

```
.
├── docker-compose.yml  # Docker Compose configuration
├── src/                # Application source code
├── nginx/              # Web server
└── README.md           # Project documentation
```

## Troubleshooting

- Ensure Docker and Docker Compose are properly installed and running.
- Check for port conflicts or missing environment variables in the `docker-compose.yml` file.

## Security Scanning

To ensure the security of your Docker images, you can use [Trivy](https://github.com/aquasecurity/trivy) to scan for vulnerabilities. Follow these steps:

1. Install Trivy by following the instructions in the [official documentation](https://aquasecurity.github.io/trivy/).

2. Scan all images defined in your `docker-compose.yml` file and save the results to `all_images_scan.txt`:
    ```bash
    trivy image --input docker-compose.yml > all_images_scan.txt
    ```

3. Review the `all_images_scan.txt` file for any vulnerabilities and address them as needed.