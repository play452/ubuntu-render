FROM ubuntu:22.04

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN echo 'root:root' | chpasswd

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install Docker using the official script
RUN curl -fsSL https://get.docker.com | sh

# Verify Docker installation
RUN docker --version

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
