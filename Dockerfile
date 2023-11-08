FROM debian:latest

# Install necessary packages
RUN apt-get update && \
    apt install -y systemd nano software-properties-common curl lsb-release

# Install necessary packages
RUN apt update && \
    apt install -y shellinabox && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:Sadri@123' | chpasswd

# Expose the SSH port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
