FROM debian:latest

# Install necessary packages
RUN apt-get update && \
    apt install -y systemd && \
    apt install -y software-properties-common && \
    apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key and repository:
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io
    
# Install necessary packages
RUN apt update && \
    apt install -y shellinabox && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && dpkg -i cloudflared.deb && \
    cloudflared service install eyJhIjoiN2Q4ZGI3YTgzODU5MjQxZDdmMDI4ZmM2MjhkOTcxNmMiLCJ0IjoiMjA5ZjNiZmUtZWFiNC00ZTdlLWI3OWEtYjllYjMzOGYyMDY1IiwicyI6Ik1UWTRZalU0TjJRdE5qQm1ZUzAwTXprekxUbGtZbVF0T1RCaU1HWmlOV1pqTkRZdyJ9 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:Sadri@123' | chpasswd

# Expose the SSH port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
