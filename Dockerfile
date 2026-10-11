# ROS 2 Jazzy + Gazebo Harmonic dev image for gz-multirobot-bridge
FROM osrf/ros:jazzy-desktop

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      ros-jazzy-ros-gz \
      ros-jazzy-nav2-bringup \
      ros-jazzy-slam-toolbox \
      ros-jazzy-xacro \
      python3-colcon-common-extensions python3-rosdep python3-pytest \
      build-essential cmake ninja-build gdb clang-format git vim \
      mesa-utils xvfb x11-utils \
    && rm -rf /var/lib/apt/lists/*

# Headers for writing gz-sim plugins (Phase 1). Separate step so a missing package name
# doesn't break the whole image; if it fails, find the right dev package with `apt search gz-sim`.
RUN apt-get update && (apt-get install -y --no-install-recommends libgz-sim8-dev \
      || echo "WARNING: libgz-sim8-dev not found - fix before building plugins") \
    && rm -rf /var/lib/apt/lists/*

# Non-root user (ubuntu, uid 1000, ships in the base image) so mounted files keep sane ownership
USER ubuntu
RUN mkdir -p /home/ubuntu/ws
WORKDIR /home/ubuntu/gz-multirobot-bridge

COPY --chown=ubuntu:ubuntu docker/entrypoint.sh /home/ubuntu/entrypoint.sh
RUN chmod +x /home/ubuntu/entrypoint.sh && \
    echo 'source /home/ubuntu/entrypoint.sh' >> /home/ubuntu/.bashrc

ENTRYPOINT ["/home/ubuntu/entrypoint.sh"]
CMD ["bash"]
