# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install Docker
RUN apt update && \
    apt install -y systemd && \
    apt install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt update && \
    apt install -y docker-ce

# Install necessary packages
RUN apt update && \
    apt install -y shellinabox && \
    docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1 && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    cloudflared service install eyJhIjoiN2Q4ZGI3YTgzODU5MjQxZDdmMDI4ZmM2MjhkOTcxNmMiLCJ0IjoiMjA5ZjNiZmUtZWFiNC00ZTdlLWI3OWEtYjllYjMzOGYyMDY1IiwicyI6Ik1UWTRZalU0TjJRdE5qQm1ZUzAwTXprekxUbGtZbVF0T1RCaU1HWmlOV1pqTkRZdyJ9 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:root' | chpasswd

# Expose the SSH port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
