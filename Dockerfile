FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y shellinabox sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'root:root' | chpasswd

# Install Docker
RUN apt-get install -y docker-ce docker-ce-cli containerd.io && \
    systemctl enable docker.service && \
    systemctl start docker.service

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
