#!/bin/bash

export ROS_MASTER_URI=http://192.168.143.125:11311;
export ROS_IP=192.168.143.125;

echo "source /gbplanner_ws/devel/setup.bash" > ~/.bashrc
source /gbplanner_ws/devel/setup.bash

case "$1" in
        explore)
            roslaunch gbplanner rover_outdoor.launch
            ;;

        bridge)
            source /opt/ros/dashing/setup.bash
            export ROS_DOMAIN_ID=$2
            ros2 run ros1_bridge dynamic_bridge --bridge-all-1to2-topics
            ;; 

        testros2)
            source /opt/ros/dashing/setup.bash
            ros2 run demo_nodes_cpp talker
            ;;

        bash)
            /bin/bash
            ;;
        *)
            echo $"Usage: $1 {explore|bridge|bash}"
            exit 1
 
esac
