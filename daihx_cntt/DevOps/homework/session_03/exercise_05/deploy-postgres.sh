
#!/bin/bash

set -e

CONTAINER_NAME="rikkei-db"
IMAGE_NAME="postgres:13"
DATA_DIR="/opt/rikkei/pg-data"
DB_PASSWORD="Rikkei@2026"

# 1. Create host data directory
sudo mkdir -p "$DATA_DIR"

# 2. Set ownership for PostgreSQL
sudo chown -R 999:999 "$DATA_DIR"

# 3. Pull PostgreSQL image
sudo docker pull "$IMAGE_NAME"

# 4. Remove existing container if it exists
if sudo docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    sudo docker rm -f "$CONTAINER_NAME"
fi

# 5. Run PostgreSQL container
sudo docker run -d \
    --name "$CONTAINER_NAME" \
    -e POSTGRES_PASSWORD="$DB_PASSWORD" \
    -v "$DATA_DIR:/var/lib/postgresql/data" \
    "$IMAGE_NAME"

# 6. Wait for PostgreSQL to become ready
echo "Waiting for PostgreSQL..."

for i in {1..30}; do
    if sudo docker exec "$CONTAINER_NAME" pg_isready -U postgres >/dev/null 2>&1; then
        echo "PostgreSQL is ready!"
        break
    fi
    sleep 2
done

# 7. Verify container
sudo docker ps --filter "name=$CONTAINER_NAME"

# 8. Verify persistent data on host
echo "PostgreSQL data directory:"
sudo ls -l "$DATA_DIR"
