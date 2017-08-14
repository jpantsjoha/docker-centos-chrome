#!/bin/bash
# Entry script to start Xvfb and set display

# Set the defaults
DEFAULT_LOG_LEVEL="INFO" # Available levels: TRACE, DEBUG, INFO (default), WARN, NONE (no logging)
DEFAULT_RES="1600x900x24"
DEFAULT_DISPLAY=":99"
DEFAULT_ROBOT_TESTS="false"
DEFAULT_OUTPUT_DIR="/tmp/"

# Start Xvfb
echo -e "Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb ${DISPLAY} -ac -screen 0 ${RES} +extension RANDR &
export DISPLAY=${DISPLAY}
