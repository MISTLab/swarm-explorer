#!/bin/bash

export ROS_MASTER_URI=http://192.168.143.125:11311;
export ROS_IP=192.168.143.125;

source /sensing-ws/install/setup.bash

rosrun object_detection main robot_id:=$1
