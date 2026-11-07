
#!/bin/bash

set -e

CONTAINER_NAME="rikkei-frontend-qa"
IMAGE_NAME="nginx"
API_ENDPOINT="https://qa-api.rikkei.edu.vn"

# 1. Pull nginx image
sudo docker pull "$IMAGE_NAME"

# 2. Remove existing container if it exists
if sudo docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    sudo docker rm -f "$CONTAINER_NAME"
fi

# 3. Run container with environment variable
sudo docker run -d \
    --name "$CONTAINER_NAME" \
    -e API_ENDPOINT="$API_ENDPOINT" \
    "$IMAGE_NAME"

# 4. Verify container
sudo docker ps --filter "name=$CONTAINER_NAME"

# 5. Execute bash inside container
echo "Accessing container..."
sudo docker exec -it "$CONTAINER_NAME" bash
