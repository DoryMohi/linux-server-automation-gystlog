#!/bin/bash

# Create groups
sudo groupadd webteam
sudo groupadd supportteam

# Create users
sudo useradd -m -s /bin/bash -G sudo admin
sudo useradd -m -s /bin/bash -G webteam dev
sudo useradd -m -s /bin/bash -G supportteam support

# Create custom files
sudo bash -c 'echo "Admin instructions" > /home/admin/readme.txt'
sudo bash -c 'echo "Developer instructions" > /home/dev/readme.txt'
sudo bash -c 'echo "Support instructions" > /home/support/readme.txt'

# Set ownership
sudo chown admin:admin /home/admin/readme.txt
sudo chown dev:dev /home/dev/readme.txt
sudo chown support:support /home/support/readme.txt

# Set permissions (640: read/write owner, read group, none others)
sudo chmod 640 /home/admin/readme.txt
sudo chmod 640 /home/dev/readme.txt
sudo chmod 640 /home/support/readme.txt

# Configure umask and aliases in .bashrc for each user
for USER_HOME in /home/admin /home/dev /home/support; do
    sudo bash -c "cat << 'EOF' >> ${USER_HOME}/.bashrc

umask 027
alias ll='ls -la'
alias update='sudo apt update && sudo apt upgrade -y'
alias cls='clear'
EOF"
done

echo "User and group setup completed."
