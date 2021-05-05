FROM ros:melodic-perception

# Catkin tools
RUN apt-get update && apt-get install -y --no-install-recommends libopenni2-dev wget && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' && \
    wget http://packages.ros.org/ros.key -O - | apt-key add - && \
    apt-get remove -y wget && \
    apt-get update && \
    apt-get install -y --no-install-recommends python-catkin-tools && \
    rm -rf /var/lib/apt/lists/* &&\
    apt-get clean


# gb_planning
RUN apt update && apt install -y \
    libproj-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libyaml-cpp-dev \
    autoconf \
    libtool m4 automake &&\
    rm -rf /var/lib/apt/lists/* &&\
    apt-get clean

# Installing ROS 2
RUN apt update && apt install -y curl gnupg2 lsb-release &&\
    rm -rf /var/lib/apt/lists/* &&\
    apt-get clean
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt update && apt install -y ros-dashing-desktop libpython3-dev python3-pip \
    python3-colcon-common-extensions ros-dashing-ros1-bridge &&\
    rm -rf /var/lib/apt/lists/*  &&\
    apt-get clean

RUN pip3 install -U argcomplete

# Edition tools
RUN apt update && apt install -y nano &&\
    rm -rf /var/lib/apt/lists/*  &&\
    apt-get clean

ARG UPDATE=0

RUN git clone https://git.mistlab.ca/vvaradharajan/gbplanner_ws &&\
    cd gbplanner_ws &&\
    wstool init &&\
    wstool merge packages_https_no_sim_rover.rosinstall &&\
    wstool update &&\
    apt update &&\
    rosdep install --from-paths src --ignore-src -r -y &&\
    apt-get clean


RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-navigation ros-melodic-pointcloud-to-laserscan && \
    rm -rf /var/lib/apt/lists/*  &&\
    apt-get clean

RUN cd gbplanner_ws &&\
    source /opt/ros/melodic/setup.bash &&\
    cd src/exploration/gbplanner_ros && git pull && git checkout rover && cd ../../.. &&\
    catkin build -DCMAKE_BUILD_TYPE=Release

ARG REPULL=0
RUN cd gbplanner_ws &&\
    cd src/exploration/gbplanner_ros &&\
    git pull &&\
    git checkout rover &&\
    cd ../pci_mav &&\
    git pull &&\
    git checkout rover &&\
    cd ../target_finder &&\
    git pull origin master &&\
    source /opt/ros/melodic/setup.bash &&\
    catkin build -DCMAKE_BUILD_TYPE=Release

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN git config --global user.name "Pierre-Yves Lajoie" &&\
    git config --global user.email "pierre-yves.lajoie@polymtl.ca"
