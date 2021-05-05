#!/bin/bash
echo "source /gbplanner_ws/devel/setup.bash" > ~/.bashrc
source /gbplanner_ws/devel/setup.bash

export ROS_MASTER_URI=http://$1:11311;
export ROS_IP=$1;

case "$2" in
        explore)
            roslaunch gbplanner rover_outdoor.launch robot_id:=$3
            ;;

        bridge)
            source /opt/ros/dashing/setup.bash
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
            echo $"Usage: $2 {explore|bridge|bash}"
            exit 1
 
esac
