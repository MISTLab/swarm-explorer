#!/bin/bash
source /opt/ros/dashing/setup.bash

ros2 run tf2_ros static_transform_publisher 5 0 0 0.0 0.0 0.0 r0/map r1/map &

ros2 run tf2_ros static_transform_publisher 5 0 0 0.0 0.0 0.0 r1/map r2/map
