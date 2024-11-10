#!/bin/bash

# Server IP and port to connect to
SERVER="127.0.0.1"
PORT=65432

# Prompt user for domain and IP
read -p "Enter domain name: " domain
read -p "Enter IP address: " ip

# Send the domain and IP to the server using Netcat
echo "$domain $ip" | nc $SERVER $PORT
