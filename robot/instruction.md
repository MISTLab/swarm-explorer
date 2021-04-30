# General setup

- Clone this repo in `/home/rover`

- Copy `robot/bash_aliases` file to `~/.bash_aliases`: run `cp
  /home/rover/robot/bash_aliases ~/.bash_aliases`

- NVIDIA AGX - Use max power: run `sudo nvpmodel -m 0`

- `cp /home/rover/robot/object-detection/txdocker /usr/local/bin/`

- Rename the default ROS workspace: `mv ~/catkin_ws ~/drivers_ws`

- Install lidar driver: clone `https://github.com/ouster-lidar/ouster_example`
  into the src folder of the ROS workspace, then run `catkin build`

- Install camera driver: `sudo apt install ros-melodic-realsense2-camera` 

# Networking

- Install batman-adv: download the alfred, batctl and batman-adv sources from
  `https://downloads.open-mesh.org/batman/releases/batman-adv-2020.4/`. Extract
  the `.tar.gz` archives and run `make` then `make install` in each.

- In `/etc/NetworkManager/conf.d/10-globally-managed-devices.conf`, append 
```
[keyfile]
unmanaged-devices=wlan0
```

- Change hostname to rover1, rover2, etc. Edit `/etc/hostname`

- `sudo cp /home/rover/swarm-explorer/robot/config/copymac.sh
  /usr/local/bin/copymac.sh`

- `sudo cp /home/rover/swarm-explorer/robot/config/batman-cl@.service
  /etc/systemd/system/batman-cl@.service`

- Make sure `/etc/network/interfaces``contains only:
```
auto lo
iface lo inet loopback
```

- `sudo systemctl status batman-cl@wlan0`, then reboot.

- Add IP infos for ROS in `~/.bashrc`: Append the following lines: 
```
source /opt/ros/melodic/setup.bash
source ~/drivers_ws/devel/setup.bash

export ROS_IP=192.168.143.125
export ROS_MASTER_URI=http://192.168.143.125:11311
```

- Replace `192.168.143.125` with the bat0 IP address in `~/.bashrc` and `robot/entrypoint.sh`

# Containers

- In `robot/`, run : `docker build . --tag lajoiepy/swarm-explorer:arm64`

- In `robot/object-detection/`, run : `docker build . --tag object-detection`
# How to run

All the important commands have an alias in `~/.bash_aliases`.

- `lidar` : launches the ouster lidar
- `cameras` : launches the cameras
- `roverstart` : launches the rover controller
- `explorer` : launches the exploration stack
- `plan` : starts the planner
- `objects` : launches the object detection
