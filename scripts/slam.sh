#!/bin/bash

# Kill child processes on exit (e.g. Ctrl+C)
trap "kill 0" SIGINT SIGTERM EXIT

# Start the slam launch (in the foreground)
ros2 launch linorobot2_navigation slam.launch.py rviz:=false
