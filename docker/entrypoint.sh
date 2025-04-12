#!/bin/bash
set -e

# Source ROS and workspaces
source /opt/ros/${ROS_DISTRO}/setup.bash
echo "Sourced ROS ${ROS_DISTRO}"

if [ -f /underlay_ws/devel/setup.bash ]; then
  source /underlay_ws/devel/setup.bash
  echo "Sourced underlay workspace"
fi

if [ -f /overlay_ws/devel/setup.bash ]; then
  source /overlay_ws/devel/setup.bash
  echo "Sourced overlay workspace"
fi


# If a command (e.g., bash) is passed, just execute that command
exec "$@"
