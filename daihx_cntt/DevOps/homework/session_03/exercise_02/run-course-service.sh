
#!/bin/bash

set -e

CONTAINER_NAME="rikkei-course-service"
IMAGE_NAME="nginxdemos/hello"

# 1. Pull Docker image
sudo docker pull "$IMAGE_NAME"

# 2. Remove existing container if it exists
if sudo docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    sudo docker rm -f "$CONTAINER_NAME"
fi

# 3. Run container in detached mode
sudo docker run -d \
    --name "$CONTAINER_NAME" \
    -p 8081:80 \
    "$IMAGE_NAME"

# 4. Verify container
echo "Checking Docker container..."
sudo docker ps --filter "name=$CONTAINER_NAME"

# 5. Test HTTP response
echo "Testing HTTP response..."
curl -I http://localhost:8081

echo "Course service started successfully!"
