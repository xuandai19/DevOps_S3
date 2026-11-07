
#!/bin/bash

set -e

CONTAINER_NAME="rikkei-course-service"
IMAGE_NAME="nginxdemos/hello"
LOG_FILE="/opt/rikkei/deploy.log"

# 1. Append all output to log file and display on terminal
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "========== Starting deployment =========="

# 2. Check whether the container exists
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then

    log "Container $CONTAINER_NAME exists."

    # 3. Stop container if it is running
    if [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME")" = "true" ]; then
        log "Stopping container $CONTAINER_NAME..."
        docker stop "$CONTAINER_NAME"
    fi

    # 4. Remove old container
    log "Removing old container $CONTAINER_NAME..."
    docker rm "$CONTAINER_NAME"

else
    log "Container $CONTAINER_NAME does not exist."
fi

# 5. Pull latest image
log "Pulling image $IMAGE_NAME..."
docker pull "$IMAGE_NAME"

# 6. Start new container
log "Starting new container..."
docker run -d \
    --name "$CONTAINER_NAME" \
    -p 8081:80 \
    "$IMAGE_NAME"

# 7. Verify deployment
log "Checking container status..."
docker ps --filter "name=$CONTAINER_NAME"

# 8. Test HTTP response
log "Testing service..."
curl -I http://localhost:8081

log "Deployment completed successfully!"
log "========== Deployment finished =========="
