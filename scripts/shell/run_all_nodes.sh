#!/bin/bash

mkdir temp_data
if [ -z "$1" ]; then
  echo "选择默认配置文件"
elif [ "$1" = "jiuzhi" ]; then
	rm temp_data/*
  ln data/jiuzhi/* temp_data/
	ln config/jiuzhi/* temp_data/

elif [ "$1" = "little_truck" ]; then
  rm temp_data/*
	ln data/little_truck/* temp_data/
	ln config/little_truck/* temp_data/

elif [ "$1" = "breton" ]; then
  rm temp_data/*
	ln data/breton/* temp_data/
	ln config/breton/* temp_data/
else
  echo "未知参数"
fi

source ./devel/steup.bash
{
	gnome-terminal -t "roscore" -x bash -c "roscore;exec bash"
	sleep 1s
	gnome-terminal -t "n_info_router" -x bash -c "source devel/setup.bash;rosrun n_info_router n_info_router;exec bash" 
	gnome-terminal -t "n_v_state" -x bash -c "source devel/setup.bash; rosrun n_v_state n_v_state;exec bash" 
	gnome-terminal -t "n_obstacle" -x bash -c "source devel/setup.bash; rosrun n_obstacle n_obstacle;exec bash" 
	gnome-terminal -t "n_show" -x bash -c "source devel/setup.bash; rosrun n_show n_show;exec bash" 
	# gnome-terminal -t "n_v_decision" -x bash -c "source devel/setup.bash; rosrun n_v_decision n_v_decision | tee decision_log.txt;exec bash"
	# gnome-terminal -t "n_local_planning" -x bash -c "source devel/setup.bash; rosrun n_local_planning n_local_planning | tee pannning_log.txt;exec bash"
	gnome-terminal -t "node_vehicle_decision" -x bash -c "source devel/setup.bash; rosrun node_vehicle_decision node_vehicle_decision;exec bash"
	
	sleep 1s
#	gnome-terminal -t "rviz" -x bash -c "source devel/setup.bash; rviz -d global_decision.rviz;exec bash"
#	gnome-terminal -t "rviz" -x bash -c "source devel/setup.bash; rviz --opengl 300 -d config/global_decision_marker.rviz;exec bash"
	gnome-terminal -t "rqt" -x bash -c "source devel/setup.bash; rqt --force-discover --perspective-file temp_data/rqt.perspective;exec bash"
#	gnome-terminal -t "car_model" -x bash -c "source devel/setup.bash; roslaunch car_model spawn_car.launch ;exec bash"
#	gnome-terminal -t "record_process_info" -x bash -c "./record_process_info.sh; exec bash"
}
