#!/bin/bash

while true
do
    # 每隔一分钟检查一次文件夹下文件数量
    # 休眠60秒
    sleep 60
    # 统计log目录下的文件数量
    file_count=$(ls -1q ./log | wc -l)
    echo "当前文件夹下文件数量为：$file_count"

    # 将所有文件按照创建的时间进行划分，最近10分钟之内的文件归到A数组，十分钟之前的文件归到B数组
    # 数组A和B
    A=()
    B=()
    # 遍历指定目录下的文件
    for file in ./log/*
    do
        if [ -f "$file" ]
        then
            # 计算文件寿命
            time_diff=$(( $(date +%s) - $(stat -c %Y "$file") ))
            if [ $time_diff -le 60 ]
            then
                A+=("$file") # 向数组中增加元素
            else
                B+=("$file")
            fi
        fi
    done

    # 将B数组内的文件删除
    # 遍历数组
    for file in "${B[@]}"
    do
        rm "$file"
        echo "已删除文件：$file"
    done

done

