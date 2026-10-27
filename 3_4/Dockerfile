FROM docker:latest

# Define environment variables for Docker Hub credentials
# These act as placeholders to be overridden during docker run
ENV DOCKER_USER=""
ENV DOCKER_PWD=""

# Copy the builder script into the container
COPY builder.sh /usr/local/bin/builder.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/builder.sh

# Set the script as the entrypoint
# Arguments passed during `docker run` will be appended here
ENTRYPOINT ["/usr/local/bin/builder.sh"]
