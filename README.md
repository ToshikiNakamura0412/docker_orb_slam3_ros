# docker_orb_slam3_ros

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The docker environment for [ORB-SLAM3](https://github.com/thien94/orb_slam3_ros.git) with ROS.

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
