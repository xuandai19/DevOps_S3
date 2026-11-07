
#!/bin/bash

set -e

CONTAINER_NAME="rikkei-course-service"

# Check whether the container exists
if ! sudo docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    echo "Error: Container $CONTAINER_NAME does not exist!"
    exit 1
fi

# Extract the last 15 log lines with timestamps
echo "Last 15 log lines of $CONTAINER_NAME:"
sudo docker logs --tail 15 --timestamps "$CONTAINER_NAME"
