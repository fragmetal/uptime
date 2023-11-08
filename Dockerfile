FROM debian:latest

# Install necessary packages
RUN apt-get update && \
    apt install -y systemd nano && \
    apt install -y software-properties-common && \
    apt install -y curl gnupg lsb-release

# Install necessary packages
RUN apt update && \
    apt install -y shellinabox && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    cloudflared service install eyJhIjoiN2Q4ZGI3YTgzODU5MjQxZDdmMDI4ZmM2MjhkOTcxNmMiLCJ0IjoiMjA5ZjNiZmUtZWFiNC00ZTdlLWI3OWEtYjllYjMzOGYyMDY1IiwicyI6Ik1UWTRZalU0TjJRdE5qQm1ZUzAwTXprekxUbGtZbVF0T1RCaU1HWmlOV1pqTkRZdyJ9 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:Sadri@123' | chpasswd && \
    echo "hostname Relay" >> ~/.bashrc

# Expose the SSH port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
