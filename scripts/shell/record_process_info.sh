#!/bin/bash
# 进程的名字
PROCESSES=("n_v_decision/n_v_decision" "n_local_planning/n_local_planning" )
# 每个进程对应的日志文件的名字，注意和PROCESSES保持一样的长度
LOG_FILES=("n_v_decision_process_info_log.txt" "n_local_planning_process_info_log.txt")
#过滤出需要的进程ID
PIDS=()
for process in ${PROCESSES[@]}
do
    echo "The value is: $process"
    PID=$(ps aux| grep $process | grep -v 'grep' | awk '{print $2;}')
    PIDS[${#PIDS[@]}]=$PID
done
echo ${PIDS[*]}

########## 将所有的日志信息放到多个文件中 ###########
for log_file in ${LOG_FILES[@]}
do
    #删除上次的监控文件
    if [ -f "$log_file" ];then
        rm "$log_file"
    fi
    # 重新创建对应的文件
    echo "USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND" >> "$log_file" 
done
echo ${LOG_FILES[*]}

# 记录日志信息到文件
while :
do
    for ((i = 0; i<${#PIDS[@]}; i++)) do
        echo $(ps aux| grep ${PIDS[i]}| grep -v 'grep') "">> "${LOG_FILES[i]}"
    done;
    sleep 5
done
########## 将所有的日志信息放到多个文件中 END ###########



# ########## 将所有的日志信息放到一个文件中 ###########
# LOG="./process_info_log.txt"
# #删除上次的监控文件
# if [ -f "$LOG" ];then
# rm "$LOG"
# fi
# echo "USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND" >> "$LOG" 

# while :
# do
#     for pid in ${PIDS[@]}
#     do
#         echo $(ps aux| grep $pid| grep -v 'grep') "">> "$LOG"
#     done
#     sleep 5
# done
# ########## 将所有的日志信息放到一个文件中 END ###########