#!/bin/bash
sudo dnf update -y
sudo dnf install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "Hello from my Nginx server!" > /usr/share/nginx/html/index.html