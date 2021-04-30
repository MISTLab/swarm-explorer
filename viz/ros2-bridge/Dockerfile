FROM ros:melodic-perception

# Installing ROS 2
RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt update && apt install -y ros-dashing-desktop libpython3-dev python3-pip \
    python3-colcon-common-extensions ros-dashing-ros1-bridge && \
    rm -rf /var/lib/apt/lists/* \
    && apt-get clean  

RUN pip3 install -U argcomplete

# Catkin tools
RUN apt-get update && apt-get install -y --no-install-recommends libopenni2-dev wget && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' && \
    wget http://packages.ros.org/ros.key -O - | apt-key add - && \
    apt-get remove -y wget && \
    apt-get update && \
    apt-get install -y --no-install-recommends python-catkin-tools && \
    rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# gb_planning
RUN apt update && apt install -y \
    libproj-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libyaml-cpp-dev \
    autoconf \
    libtool m4 automake && \
    rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN apt-get update && \
    apt-get -y install libgl1-mesa-glx libgl1-mesa-dri && \
    rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ARG UPDATE=0

RUN git clone https://git.mistlab.ca/vvaradharajan/gbplanner_ws &&\
    cd gbplanner_ws &&\
    wstool init &&\
    wstool merge packages_https_no_sim.rosinstall &&\
    wstool update &&\
    apt update &&\
    rosdep install --from-paths src --ignore-src -r -y &&\
    rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN cd gbplanner_ws &&\
    source /opt/ros/melodic/setup.bash &&\
    cd src/exploration/gbplanner_ros &&\
    git pull && git checkout rover &&\
    cd ../../.. && catkin build -DCMAKE_BUILD_TYPE=Release

RUN mv gbplanner_ws/src/exploration/gbplanner_ros/gbplanner/config/rviz/mist.rviz .

# RUN apt install -y ros-dashing-launch*
# RUN mkdir bridge-ws && mkdir bridge-ws/src &&\
#    cd bridge-ws/src && git clone https://github.com/ros2/ros1_bridge.git &&\
#    cd ros1_bridge && git checkout dashing &&\
#     source /opt/ros/melodic/setup.bash &&\
#     source /opt/ros/dashing/setup.bash &&\
#     colcon build --packages-select ros1_bridge --cmake-force-configure &&\
#     colcon build

RUN echo "export ROS_MASTER_URI=http://192.168.143.125:11311; export ROS_IP=192.168.143.130; source /gbplanner_ws/devel/setup.bash" > ~/.bashrc