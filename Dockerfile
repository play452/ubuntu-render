FROM ubuntu:22.04

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y curl sudo && \
    rm -rf /var/lib/apt/lists/*
RUN echo 'root:root' | chpasswd
RUN sudo su

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install Docker using the official script
RUN curl -fsSL https://get.docker.com | sh

# Verify Docker installation
RUN docker --version

# Run Docker
RUN sudo dockerd --host unix:///var/run/docker.sock

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
