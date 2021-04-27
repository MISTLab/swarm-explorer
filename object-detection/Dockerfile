FROM ros:noetic-perception

# Catkin tools
RUN apt update && \
    apt install python3-catkin-tools python3-osrf-pycommon && \
    rm -rf /var/lib/apt/lists/*

# Edition tools
RUN apt update && apt install -y nano git dos2unix

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir sensing-ws && mkdir sensing-ws/src && cd sensing-ws/src &&\
    git clone https://github.com/lajoiepy/object-detection.git

RUN cd sensing-ws && source /opt/ros/noetic/setup.bash &&\
    catkin build

RUN git config --global user.name "Pierre-Yves Lajoie" &&\
    git config --global user.email "pierre-yves.lajoie@polymtl.ca"

COPY yolov3.weights sensing-ws/src/object-detection/config/darknet_resources/weights/yolov3.weights
