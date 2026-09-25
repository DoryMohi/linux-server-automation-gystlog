#!/bin/bash

# Create base directory structure
sudo mkdir -p /srv/gystlog/web
sudo mkdir -p /srv/gystlog/exchange
sudo mkdir -p /srv/gystlog/logs

# Set ownership
sudo chown admin:webteam /srv/gystlog/web
sudo chown admin:webteam /srv/gystlog/exchange
sudo chown admin:supportteam /srv/gystlog/logs

# Set permissions
# 770: full access for owner and webteam group
sudo chmod 770 /srv/gystlog/web
# 1770: sticky bit enabled for shared directory
sudo chmod 1770 /srv/gystlog/exchange
# 750: owner full, supportteam read/execute
sudo chmod 750 /srv/gystlog/logs

# Add www-data (Nginx user) to webteam group for web server read access
sudo usermod -aG webteam www-data

# Create symbolic links (force overwrite if already exists)
sudo ln -sf /srv/gystlog/web /home/dev/web_link
sudo ln -sf /srv/gystlog/logs /home/support/logs_link

echo "Directory structure configured successfully."
