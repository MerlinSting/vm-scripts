#!/bin/bash

read -p "Enter SMB share location (e.g., //server/share): " SMB_SHARE
read -p "Enter mount point (e.g., /mnt/share): " MOUNT_POINT

read -p "Enter SMB username: " SMB_USERNAME
read -sp "Enter SMB password: " SMB_PASSWORD

echo
read -p "Enter uid of the mount point: " UID_VALUE
read -p "Enter gid of the mount point: " GID_VALUE

# Check for dependencies
if ! command -v cifs-utils &> /dev/null; then
    echo "cifs-utils could not be found. Installing..."
    sudo apt-get update -y
    sudo apt-get install -y cifs-utils
fi

# Create mount point if it does not exist
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT"
fi

# Mount the SMB share
sudo mount -t cifs "$SMB_SHARE" "$MOUNT_POINT" -o username="$USERNAME",password="$PASSWORD"

# Check if the mount was successful
if [ $? -eq 0 ]; then
    echo "SMB share mounted successfully at $MOUNT_POINT"
else
    echo "Error mounting SMB share."
    echo "Please check the following:"
    echo "- SMB share path: $SMB_SHARE"
    echo "- Mount point: $MOUNT_POINT"
    echo "- Username: $SMB_USERNAME"
    echo "- Password (ensure it is correct)"
    echo "Possible error messages from mount command:"
    sudo mount -t cifs "$SMB_SHARE" "$MOUNT_POINT" -o username="$SMB_USERNAME",password="$SMB_PASSWORD" 2>&1
    exit 1
fi

# Add entry to /etc/fstab for automatic mounting on boot
CREDENTIALS_FILE="/etc/smbcredentials"

echo "username=$SMB_USERNAME" | sudo tee "$CREDENTIALS_FILE" > /dev/null
echo "password=$SMB_PASSWORD" | sudo tee -a "$CREDENTIALS_FILE" > /dev/null

# Restrict access to the credentials file
sudo chmod 600 "$CREDENTIALS_FILE"

# Add entry to /etc/fstab
FSTAB_ENTRY="$SMB_SHARE $MOUNT_POINT cifs credentials=$CREDENTIALS_FILE,iocharset=utf8,sec=ntlm,uid=$UID_VALUE,gid=$GID_VALUE,file_mode=0777,dir_mode=0777 0 0"

echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null

# Test the mount
sudo mount -a

if [ $? -eq 0 ]; then
    echo "Entry added to /etc/fstab and SMB share mounted successfully."
else
    echo "Error mounting SMB share. Please check the credentials and network connection."
    exit 1
fi