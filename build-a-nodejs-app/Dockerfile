FROM node:alpine3.17

USER node

# Create a working directory
WORKDIR /app

# Copy the entrypoint script
COPY entrypoint.sh entrypoint.sh
COPY --chown=node:node index.js index.js

USER root
# Install tini
RUN apk add --no-cache tini

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

USER node

# Specify the entry point for the container
ENTRYPOINT ["/sbin/tini", "--", "./entrypoint.sh"]