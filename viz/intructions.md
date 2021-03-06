# Allow X hosting
xhost +

# Launch image
docker run \
  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  --env="DISPLAY=$DISPLAY" \
  lajoiepy/swarm-explorer

# Disallow X hosting (for safety)
xhost -