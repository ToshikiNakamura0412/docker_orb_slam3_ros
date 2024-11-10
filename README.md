# docker_orb_slam3_ros

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The docker environment for [ORB-SLAM3](https://github.com/ToshikiNakamura0412/orb_slam3_ros.git) with ROS.

![image](https://github.com/ToshikiNakamura0412/docker_orb_slam3_ros/wiki/images/docker_orb_slam3_ros.png)

## Environment
### OS
- Ubuntu

### Mount
- bagfiles
  - Source: `~/bagfiles`
  - Destination: `/home/user/bagfiles`
- x11
  - Source: `/tmp/.X11-unix`
  - Destination: `/tmp/.X11-unix`

## Setup
```bash
make setup
make build
```

## Usage
### Run
```bash
docker compose up -d
docker compose exec ws <command (e.g. bash, tmux)>
```

### Execute ORB-SLAM3 (in the container)
```bash
roslauch orb_slam3_ros ~.launch
```

### Stop
```bash
docker compose down
```
