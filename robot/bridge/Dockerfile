FROM ros:melodic-perception

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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN git config --global user.name "Pierre-Yves Lajoie" &&\
    git config --global user.email "pierre-yves.lajoie@polymtl.ca"