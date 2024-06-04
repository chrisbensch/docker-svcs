# Use a lightweight base image
FROM alpine:latest

# Install Tor
RUN apk update && apk add --no-cache tor

# Create necessary directories
RUN mkdir -p /etc/tor /var/lib/tor

# Copy default Tor configuration
COPY torrc /etc/tor/torrc

# Expose the ports for Tor
EXPOSE 9050 9051

# Run Tor
CMD ["tor", "-f", "/etc/tor/torrc"]
