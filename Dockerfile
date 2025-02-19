ARG FROM_IMAGE=ros:humble

FROM $FROM_IMAGE

ARG OVERLAY_WS=/opt/ros/overlay_ws

RUN apt-get update \
    && apt-get install -y lsb-release wget gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Python and pip first
RUN apt-get update && apt-get install -y python3 python3-pip

# For colcon to build python packages without errors we'll need
RUN pip install setuptools==58.2.0

RUN apt-get update
# Install Gazebo
RUN apt install -y ros-humble-gazebo-*

# Install Cartographer
RUN apt install -y ros-humble-cartographer
RUN apt install -y ros-humble-cartographer-ros

# Install Navigation2
RUN apt install -y ros-humble-navigation2
RUN apt install -y ros-humble-nav2-bringup

# Build turtlebot4 and ros_gz from source
WORKDIR $OVERLAY_WS/src
RUN git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
RUN git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
RUN apt install python3-colcon-common-extensions

WORKDIR $OVERLAY_WS
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    apt-get update && rosdep install -y \
      --from-paths src \
      --ignore-src \
    && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build --symlink-install

# source entrypoint setup
ENV OVERLAY_WS=$OVERLAY_WS

RUN sed --in-place --expression \
      '$isource "$OVERLAY_WS/install/setup.bash"' \
      /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["/bin/bash"]