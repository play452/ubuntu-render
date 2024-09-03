# Start with Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /root

# Copy necessary files
COPY ./start.sh .
COPY ./docker.sh .

# Set permissions for the scripts
RUN chmod +x start.sh docker.sh

# Set the entrypoint to run the main script
ENTRYPOINT ["./start.sh"]
