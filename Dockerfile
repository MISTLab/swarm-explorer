FROM ros:melodic-perception

# Catkin tools
RUN apt-get update && apt-get install -y --no-install-recommends libopenni2-dev wget && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' && \
    wget http://packages.ros.org/ros.key -O - | apt-key add - && \
    apt-get remove -y wget && \
    apt-get update && \
    apt-get install -y --no-install-recommends python-catkin-tools && \
    rm -rf /var/lib/apt/lists/*

# gb_planning
RUN apt update && apt install -y \
    libproj-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libyaml-cpp-dev \
    autoconf \
    libtool m4 automake

ARG UPDATE=0

RUN git clone https://git.mistlab.ca/vvaradharajan/gbplanner_ws &&\
    cd gbplanner_ws &&\
    wstool init &&\
    wstool merge packages_https_no_sim.rosinstall &&\
    wstool update &&\
    apt update &&\
    rosdep install --from-paths src --ignore-src -r -y

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN cd gbplanner_ws &&\
    source /opt/ros/melodic/setup.bash &&\
    catkin build