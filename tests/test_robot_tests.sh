#!/usr/bin/env sh

docker run --rm \
        --privileged \
        -e ROBOT_TESTS=/robot_tests \
        -e OUTPUT_DIR=/output \
        -v /dev/shm:/dev/shm \
        -v ${PWD}/tests/robot_tests/output:/output/ \
        -v ${PWD}/tests/robot_tests:/robot_tests/ \
        -it tonybearpan/docker-centos-chrome
