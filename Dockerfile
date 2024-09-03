FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
apt-get install -y xterm-js && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4200

CMD ["xterm", "-t", "-s", "/"]
