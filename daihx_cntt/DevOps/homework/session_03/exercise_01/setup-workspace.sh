
#!/bin/bash

# 1. Create user if it does not exist
if ! id rikkeilms &>/dev/null; then
    sudo useradd -m -s /bin/bash rikkeilms
    echo "User rikkeilms created successfully"
else
    echo "User rikkeilms already exists"
fi

# 2. Create project directory
sudo mkdir -p /opt/rikkei/course-service

# 3. Change ownership
sudo chown -R rikkeilms:rikkeilms /opt/rikkei/course-service

# 4. Set directory permissions
sudo chmod 755 /opt/rikkei/course-service

# 5. Verify results
echo "Verification:"
id rikkeilms
ls -ld /opt/rikkei/course-service
