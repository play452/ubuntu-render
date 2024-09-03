# Use Ubuntu as the base image
FROM ubuntu:20.04

# Update package lists and install required packages
RUN apt-get update && apt-get install -y \
    git curl sudo wget nano \
    && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p /etc/pterodactyl /etc/letsencrypt /etc/letsencrypt/live /etc/letsencrypt/live/eu2node.hyghj.eu.org

# Download and set up Wings
RUN curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
RUN chmod +x /usr/local/bin/wings

# Configure Pterodactyl
RUN cd /etc/pterodactyl && \
    wings configure --panel-url https://panel.astralaxis.one --token ptla_ow7tyaIqnPooG1uX2mcVf0aVAkQUdOl1qLzF6wxJE1P --node 13

# Generate SSL certificate
RUN cd /etc/letsencrypt/live/eu2node.hyghj.eu.org && \
    openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=NA/ST=NA/L=NA/O=NA/CN=Generic SSL Certificate" -keyout privkey.pem -out fullchain.pem

# Install Cloudflared
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    cloudflared service install eyJhIjoiMWE1MTc4MTE0YTZjOWZmNDllMzZiNmMxNzVlOTZiYjkiLCJ0IjoiMWU5MTNiODMtNDM2ZC00NDM5LWFmNmMtMzFmNTRmNDAzOGIyIiwicyI6Ik56SXhaamcwT1RndFpUZ3lZeTAwTURobExUbG1ZV0l0TldVMU5HWmxZV1JoWVRGaiJ9

# Expose port 443
EXPOSE 443

# Start Wings service
CMD ["wings", "--debug"]
