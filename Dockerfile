# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install Docker
RUN apt update && \
    apt install -y systemd && \
    apt install -y apt-transport-https ca-certificates curl software-properties-common
    
# Install necessary packages
RUN apt update && \
    apt install -y shellinabox && \
    docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:root' | chpasswd

# Expose the SSH port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
