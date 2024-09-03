# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox systemd tmux tmate && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:root' | chpasswd

# Install Tmate
RUN wget -nc https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-i386.tar.xz &> /dev/null && \
    tar --skip-old-files -xvf tmate-2.4.0-static-linux-i386.tar.xz &> /dev/null && \
    rm -f nohup.out && \
    bash -ic 'nohup ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock new-session -d & disown -a' >/dev/null 2>&1 && \
    ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock wait tmate-ready && \
    ./tmate-2.4.0-static-linux-i386/tmate -S /tmp/tmate.sock display -p "#{tmate_ssh}"

# Expose ports
EXPOSE 4200 8022

# Start services
CMD ["systemctl", "start", "shellinaboxd"]
