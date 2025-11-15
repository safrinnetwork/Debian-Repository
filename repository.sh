#!/bin/bash

# Backup existing sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Detect Debian version codename
debian_version=$(lsb_release -cs)

# Clear the existing sources.list
sudo truncate -s 0 /etc/apt/sources.list

# Set repositories based on Debian version
case "$debian_version" in
  "jessie")
    echo "Setting repositories for Debian 8 (Jessie)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Debian repositories
deb http://deb.debian.org/debian/ jessie main contrib non-free
deb http://deb.debian.org/debian/ jessie-updates main contrib non-free

# Security updates
deb http://security.debian.org/ jessie/updates main contrib non-free
EOL
    ;;
  "stretch")
    echo "Setting repositories for Debian 9 (Stretch)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Debian repositories
deb http://deb.debian.org/debian/ stretch main contrib non-free
deb http://deb.debian.org/debian/ stretch-updates main contrib non-free

# Security updates
deb http://security.debian.org/ stretch/updates main contrib non-free
EOL
    ;;
  "buster")
    echo "Setting repositories for Debian 10 (Buster)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Debian repositories
deb http://deb.debian.org/debian/ buster main contrib non-free
deb http://deb.debian.org/debian/ buster-updates main contrib non-free

# Security updates
deb http://security.debian.org/ buster/updates main contrib non-free
EOL
    ;;
  "bullseye")
    echo "Setting repositories for Debian 11 (Bullseye)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Debian repositories
deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free

# Security updates
deb http://security.debian.org/ bullseye-security main contrib non-free
EOL
    ;;
  "bookworm")
    echo "Setting repositories for Debian 12 (Bookworm)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Debian repositories
deb http://deb.debian.org/debian/ bookworm main contrib non-free
deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free

# Security updates
deb http://security.debian.org/ bookworm-security main contrib non-free
EOL
    ;;
  *)
    echo "Unsupported Debian version or unable to detect version. Please check your system."
    exit 1
    ;;
esac

# Update package lists
sudo apt update

# Upgrade packages
sudo apt upgrade -y

echo "Repositories have been successfully updated and packages upgraded for Debian $debian_version."
