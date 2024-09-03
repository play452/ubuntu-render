FROM ubuntu:22.04

# Update package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git

# Install Go
RUN wget https://go.dev/dl/go1.20.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz && \
    rm go1.20.linux-amd64.tar.gz

# Install gotty
RUN go install github.com/yudai/gotty@latest

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Run gotty on port 8080
CMD ["/usr/local/go/bin/gotty", "-l", "8080"]
