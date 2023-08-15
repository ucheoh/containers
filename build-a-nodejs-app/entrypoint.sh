#!/bin/sh

# Function to handle cleanup and exit
cleanup() {
  echo "Received SIGTERM, performing cleanup"
  # Cleanup logic
  if [ ! -z "HTTP_SERVER_PID"]; then
    kill "$HTTP_SERVER_PID"
  fi

  echo "Cleanup done. Exiting."
  exit 0
}

# Register the cleanup function to handle SIGTERM
trap "cleanup" SIGTERM

# Start the Node.js app
node index.js &
HTTP_SERVER_PID=$!

# Wait for the Node.js process to complete
wait $HTTP_SERVER_PID