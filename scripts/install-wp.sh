#!/bin/bash
#      _          _      _       _                            _            _     
#  ___| |__  _ __(_)___ (_) ___ | |__  _ __  ___  ___  _ __  | |_ ___  ___| |__  
# / __| '_ \| '__| / __|| |/ _ \| '_ \| '_ \/ __|/ _ \| '_ \ | __/ _ \/ __| '_ \ 
#| (__| | | | |  | \__ \| | (_) | | | | | | \__ \ (_) | | | || ||  __/ (__| | | |
# \___|_| |_|_|  |_|___// |\___/|_| |_|_| |_|___/\___/|_| |_(_)__\___|\___|_| |_|
#                     |__/                                                       
#
# Configure Compute Engine VM and install nginx

# Set required variables



# Install the GCP Monitoring Agent 
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh --also-install
# Update package manager
sudo apt-get update -y
# Install PHP
sudo apt install php libapache2-mod-php
# Install MySql and create database / user
sudo apt install mysql-server
sudo systemctl start mysql.service
# Download and install WordPress CLI tool
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
# Install WordPress
wp core config --dbname=wordpress --dbuser=root --dbpass=root
wp core install --url=http://localhost:8888/dev/wordpress/ --title=WordPress --admin_user=myusername --admin_password=mypassword --admin_email=tfirdaus@outlook.com