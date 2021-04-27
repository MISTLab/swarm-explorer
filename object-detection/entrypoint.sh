#!/bin/bash

export ROS_MASTER_URI=http://192.168.143.125:11311;
export ROS_IP=192.168.143.125;

echo "source /sensing-ws/devel/setup.bash" > ~/.bashrc

/bin/bash
