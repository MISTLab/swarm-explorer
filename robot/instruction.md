# General setup

- Clone this repo in `/home/rover`

- Copy `robot/bash_aliases` file to `~/.bash_aliases`: run `cp /home/rover/swarm-explorer/robot/bash_aliases ~/.bash_aliases`

- NVIDIA AGX - Use max power: run `sudo nvpmodel -m 0`

- `cp /home/rover/robot/object-detection/txdocker /usr/local/bin/`

- Rename the default ROS workspace: `mv ~/catkin_ws ~/drivers_ws`

- Install catkin tools `sudo apt-get install -y --no-install-recommends python-catkin-tools`

- Install ptp4l: `sudo apt-get install -y linuxptp`

- Install lidar driver: clone `https://github.com/ouster-lidar/ouster_example`
  into the src folder of the ROS workspace, is the ouster repo run `git checkout 5c00aa97ee82`. Then run `sudo apt install ros-melodic-pcl-ros` then `source /opt/ros/melodic/setup.bash; catkin clean -y; catkin build`

- Install camera driver: `sudo apt install ros-melodic-realsense2-camera` 

- Avoid using sudo for docker: `sudo groupadd docker && sudo usermod -aG docker $USER`

- In `rr_openrover_stack` located in the `drivers_ws` run: `git remote add mist https://github.com/lajoiepy/rr_openrover_stack.git` then `git checkout willr/feature/drivertrim` then `git pull mist willr/feature/drivertrim` then `cd ../.. && catkin build`

# Networking

- Install batman-adv: download the alfred, batctl and batman-adv sources from
  `https://downloads.open-mesh.org/batman/releases/batman-adv-2020.4/`. Extract
  the `.tar.gz` archives and run `make` then `make install` in each.

- In `/etc/NetworkManager/conf.d/10-globally-managed-devices.conf`, append 
```
[keyfile]
unmanaged-devices=wlan0
```

- Change hostname to rover0, rover1, rover2, etc. Edit `/etc/hostname`

- `sudo cp /home/rover/swarm-explorer/robot/config/copymac.sh
  /usr/local/bin/copymac.sh`

- `sudo cp /home/rover/swarm-explorer/robot/config/batman-cl@.service
  /etc/systemd/system/batman-cl@.service`

- Make sure `/etc/network/interfaces``contains only:
```
auto lo
iface lo inet loopback
```

- `sudo systemctl enable batman-cl@wlan0`, then reboot.

- Add IP infos for ROS in `~/.bashrc`: Append the following lines: 
```
source /opt/ros/melodic/setup.bash
source ~/drivers_ws/devel/setup.bash

export ROS_IP=192.168.143.125
export ROS_MASTER_URI=http://192.168.143.125:11311
export ROBOT_ID=0
export LIDAR_SERIAL_NUMBER=992039000794
export LIDAR_IP=10.42.0.1
```

- Replace `192.168.143.125` with the bat0 IP address, `0` with the robot ID and `992039000794` with the lidar serial number, and `10.42.0.1` with the lidar ethernet interface IP address. Make the changes in `~/.bashrc`

# Containers

- In `robot/`, run : `docker build . --tag lajoiepy/swarm-explorer:arm64`

- In `robot/object-detection/`, run : `wget https://pjreddie.com/media/files/yolov3.weights`then `docker build . --tag lajoiepy/object-detection`
# How to run

All the important commands have an alias in `~/.bash_aliases`.

- `lidar` : launches the ouster lidar (if you have errors look at the [User Manual](https://data.ouster.io/downloads/software-user-manual/software-user-manual-v2p0.pdf) and the [ouster repo](https://github.com/ouster-lidar/ouster_example)
- `cameras` : launches the cameras
- `roverstart` : launches the rover controller
- `explorer` : launches the exploration stack
- `plan` : starts the planner
- `objects` : launches the object detection
