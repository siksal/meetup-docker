 ![The TurtleBot 3 on Gazebo Simulator in a Docker Container](/tb3.png)

# Turtlebot3 on ROS 2 Humble - Docker

This Docker container contains [ROS 2 Humble](https://docs.ros.org/en/humble/), Gazebo Classic, and the [TurtleBot 3 simulation](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/).

👉 This Docker container is meant to be used with this [LQR code for a TB3 node](tbd) and the associated ROS Meetup Lagos talk by Femi Ayoade.

👉 This Docker also includes a full ROS 2 Humble install. If you would like to brush up on your ROS skills you can work through the ROS 2 tutorials. We suggest you start with the [CLI Tutorials.](https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools.html)


# Setup Instructions

Install Docker and Rocker

* [Install Docker](https://docs.docker.com/get-started/get-docker/) on your OS platform.
* You may need to [add yourself to the Docker group](https://stackoverflow.com/questions/21871479/docker-cant-connect-to-docker-daemon) with the command `sudo usermod -aG docker $(whoami)` 
* Install Rocker:
    * Debians (Recommended): `sudo apt-get install python3-rocker`
    * If you're not on Ubuntu or Debian: `pip install rocker`

Build container from scratch

```bash 
cd 
git clone https://github.com/siksal/meetup-docker.git
cd meetup-docker
docker build . -t tb3-lqr
```

*REMEMBER **tb3-lqr*** is the name of your image in this case. You can use any name you prefer.

 ![Docker Build](/docker-build.png)


# How to Use Your Container
Start container: 
```bash 
rocker --x11 --devices=/dev/dri tb3-lqr bash
```

Source Turtlebot and Gazebo:
``` bash
echo 'source /opt/ros/overlay_ws/install/setup.bash' >> ~/.bashrc
echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc
echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc
source ~/.bashrc
export TURTLEBOT3_MODEL=burger
```

Run Turtlebot3:
```bash
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
```
 ![The TurtleBot 3 on Gazebo Simulator in a Docker Container](/tb3.png)
