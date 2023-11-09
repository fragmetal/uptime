#!/bin/bash

# Update packages
apt-get update

# Install vsftpd
apt-get install vsftpd -y

# Backup the original vsftpd configuration file
cp /etc/vsftpd.conf /etc/vsftpd.conf.orig

# Create the FTP user
useradd -m relay -s /usr/sbin/nologin
echo "relay:Sadri@123" |  chpasswd

# Configure vsftpd
echo "listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
pasv_enable=Yes
pasv_min_port=40000
pasv_max_port=40100
allow_writeable_chroot=YES
local_root=/root" |  tee /etc/vsftpd.conf

# Restart vsftpd
service vsftpd restart
