# Set the Docker host to use the Colima default socket
export DOCKER_HOST=unix:///Users/mwrightkuhns/.colima/default/docker.sock

# Disable Java Testcontainers Ryuk container, which is used for resource reaping but may not be needed with Colima
export TESTCONTAINERS_RYUK_DISABLED=true
