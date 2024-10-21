ARG ROS_DISTRO=noetic
FROM ros:${ROS_DISTRO}
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# ===================
# Basic installation
# ===================
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo git vim tmux \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-desktop \
    python3-catkin-tools
RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/apt/apt.conf.d/docker-clean

# ===================================
# Install apt packages for ORB-SLAM3
# ===================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    cmake \
    python-dev \
    python-numpy \
    build-essential \
    pkg-config \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    libglew-dev \
    libboost-all-dev \
    libssl-dev \
    libeigen3-dev \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libgtk-3-dev

# =====================
# Install ROS packages
# =====================
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-hector-trajectory-server \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-image-transport
RUN apt-get update && apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-tf

# ====================
# Change user to USER
# ====================
USER $USERNAME
ENV SHELL /bin/bash

# =========
# Pangolin
# =========
RUN cd ~/ \
    && git clone https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && sudo make install

# ======
# Setup
# ======
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ~/ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashrc
RUN echo "export ROS_WORKSPACE=~/ws" >> ~/.bashrc
RUN echo "export ROS_PACKAGE_PATH=~/ws/src:\$ROS_PACKAGE_PATH" >> ~/.bashrc

# ================
# Build ORB-SLAM3
# ================
RUN mkdir -p ~/ws/src && git clone https://github.com/thien94/orb_slam3_ros.git ~/ws/src/orb_slam3_ros
RUN cd ~/ws \
    && sudo ldconfig \
    && /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && catkin build -j4"

CMD ["/bin/bash"]
