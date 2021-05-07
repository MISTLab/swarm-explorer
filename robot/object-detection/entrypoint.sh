#!/bin/bash

export ROS_MASTER_URI=http://$1:11311;
export ROS_IP=$1;

source /sensing-ws/install/setup.bash

rosparam set robot_id $2
rosrun object_detection main 
