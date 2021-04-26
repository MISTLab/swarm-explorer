FROM ros:kinetic

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

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# ROSBuzz and dependancies
RUN apt update && apt install -y ros-kinetic-mavros*
RUN git clone https://github.com/MISTLab/Buzz buzz &&\
   cd buzz &&\
   mkdir build && cd build &&\
   cmake ../src &&\
   make install &&\
   ldconfig

RUN git clone --branch ros_drones_ws https://git.mistlab.ca/dasto/drones.git/ drones
RUN cd drones &&\
   source /opt/ros/kinetic/setup.bash &&\
   ./build_spiri.sh

# Edition tools
RUN apt update && apt install -y nano

ARG UPDATE=0

RUN git clone https://git.mistlab.ca/vvaradharajan/gbplanner_ws &&\
    cd gbplanner_ws &&\
    wstool init &&\
    wstool merge packages_https_no_sim.rosinstall &&\
    wstool update &&\
    apt update &&\
    rosdep install --from-paths src --ignore-src -r -y

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-navigation ros-kinetic-pointcloud-to-laserscan && \
    rm -rf /var/lib/apt/lists/*

RUN cd gbplanner_ws &&\
    source /opt/ros/kinetic/setup.bash &&\
    catkin build -DCMAKE_BUILD_TYPE=Release

ARG REPULL=0
RUN cd gbplanner_ws &&\
    cd src/exploration/gbplanner_ros &&\
    git pull &&\
    cd ../pci_mav &&\
    git pull origin master &&\
    cd ../target_finder &&\
    git pull origin master &&\
    source /opt/ros/kinetic/setup.bash &&\
    catkin build -DCMAKE_BUILD_TYPE=Release

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]

RUN git config --global user.name "Pierre-Yves Lajoie" &&\
    git config --global user.email "pierre-yves.lajoie@polymtl.ca"
