#!/bin/bash

export ROS_MASTER_URI=http://$1:11311;
export ROS_IP=$1;

source /opt/ros/melodic/setup.bash
source /opt/ros/dashing/setup.bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-1to2-topics
