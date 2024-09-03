FROM ubuntu:22.04

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y curl sudo && \
    rm -rf /var/lib/apt/lists/*
RUN sudo passwd root
RUN Ol
RUN Ol

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
