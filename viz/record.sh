#!/bin/bash

source /opt/ros/dashing/setup.bash; 

ros2 bag record /tf /tf_static /r0/t265/odom/sample /r1/t265/odom/sample /r2/t265/odom/sample /r0/gbplanner_node/occupied_nodes /r1/gbplanner_node/occupied_nodes /r2/gbplanner_node/occupied_nodes /r0/gbplanner_node/surface_pointcloud /r1/gbplanner_node/surface_pointcloud /r2/gbplanner_node/surface_pointcloud /object_detector/debug/image_raw /object_detector/markers
