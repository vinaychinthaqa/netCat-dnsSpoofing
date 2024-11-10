#!/bin/bash

# Trusted domain-IP list
declare -A trusted_ips
trusted_ips["google.com"]="142.250.190.78"
trusted_ips["example.com"]="93.184.216.34"
trusted_ips["yahoo.com"]="98.137.246.8"

# Port to listen on
PORT=65432

# Start the server to listen on the specified port using Netcat
echo "Server started, listening on port $PORT..."
while true; do
    # Use Netcat to listen for incoming connections
    # Read the domain and IP pair from the client
    nc -l -p $PORT | while read -r line; do
        domain=$(echo $line | cut -d' ' -f1)
        ip=$(echo $line | cut -d' ' -f2)

        # Check if the domain is in the trusted list
        if [[ -v trusted_ips["$domain"] ]]; then
            trusted_ip=${trusted_ips["$domain"]}

            if [[ "$ip" == "$trusted_ip" ]]; then
                echo "Domain $domain is associated with the trusted IP $trusted_ip."
            else
                echo "Warning: DNS spoofing detected for $domain. IP $ip does not match the trusted IP $trusted_ip."
            fi
        else
            echo "Warning: Domain $domain is not in the trusted list."
        fi
    done
done
