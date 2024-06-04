# Use a lightweight base image
FROM alpine:latest

# Create a non-root user and group
RUN addgroup -S tor && adduser -S -G tor tor

# Install Tor and create necessary directories
RUN apk update && apk add --no-cache tor geoip && \
    mkdir -p /etc/tor /var/lib/tor /run/tor 
    #&& \
    #chown -R tor:tor /etc/tor /var/lib/tor /run/tor

# Copy the default Tor configuration
COPY torrc.example /etc/tor/torrc
#RUN chown tor:tor /etc/tor/torrc

# Persist data
VOLUME /etc/tor /var/lib/tor

# Expose the ports for Tor
EXPOSE 9050 9051

# Switch to the non-root user
#USER tor

# Run Tor as the tor user
#CMD ["sh", "-c", "tor -f /etc/tor/torrc"]
ENTRYPOINT ["/usr/bin/tor", "-f", "/etc/tor/torrc"]

