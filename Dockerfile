# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages

RUN apt update && \
    apt install -y openssh-server curl && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    cloudflared service install eyJhIjoiN2Q4ZGI3YTgzODU5MjQxZDdmMDI4ZmM2MjhkOTcxNmMiLCJ0IjoiMjA5ZjNiZmUtZWFiNC00ZTdlLWI3OWEtYjllYjMzOGYyMDY1IiwicyI6Ik1UWTRZalU0TjJRdE5qQm1ZUzAwTXprekxUbGtZbVF0T1RCaU1HWmlOV1pqTkRZdyJ9 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:root' | chpasswd

# Expose the SSH port
EXPOSE 22

# Start SSH
CMD ["/usr/sbin/sshd", "-D"]
