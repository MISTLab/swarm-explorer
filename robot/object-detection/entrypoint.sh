#!/bin/bash

export ROS_MASTER_URI=http://$1:11311;
export ROS_IP=$1;

source /sensing-ws/install/setup.bash

rosrun object_detection main robot_id:=$2
