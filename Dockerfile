# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt update && \
    apt install -y openssh-server curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    curl -s https://install.zerotier.com | bash && \
    zerotier-cli join e3918db483f4a90d
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1

# Set root password
RUN echo 'root:root' | chpasswd

# Expose the SSH port
EXPOSE 22

# Start SSH
CMD ["/usr/sbin/sshd", "-D"]
