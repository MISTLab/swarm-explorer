# Allow X hosting
xhost +

# Launch image
docker run \
  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri \
  --env="DISPLAY=$DISPLAY" \ 
  --net=host --gpus all -it lajoiepy/swarm-explorer-viz

# Disallow X hosting (for safety)
xhost -
