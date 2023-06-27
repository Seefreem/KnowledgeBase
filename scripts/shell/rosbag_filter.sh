#!/bin/bash
# Command:   ./rosbag_filter.sh source.bag [target.bag]
# Example 1: ./rosbag_filter.sh 2023-01-12-10-00-00.bag 
# Example 2: ./rosbag_filter.sh 2023-01-12-10-00-00.bag state.bag 

time=$(date "+%Y-%m-%d-%H-%M-%S")
# echo "${time}"
target_bag="router_fuse_state-"${time}".bag"

if (($# < 2)) 
then
  echo "Filter data from "${1}" to "${target_bag}""
  rosbag filter $1 "${target_bag}" "topic == '/msg_v_state' or  topic == '/msg_obj_fuse' or topic == '/msg_info_router'"

else
  echo "Filter data from "${1}" to "${2}""
  rosbag filter $1 $2 "topic == '/msg_v_state' or topic == '/msg_obj_fuse' or topic == '/msg_info_router'"

fi



