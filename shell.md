

# 监控文件大小，并删除文件
```shell
FILE_NAMES=("decision_log.txt" "pannning_log.txt" )
BASE_SIZE=1048576
while :
do
	for ((i = 0; i<${#FILE_NAMES[@]}; i++)) do
		file_size=$(ls -l| grep ${FILE_NAMES[i]} | awk '{print $5;}')
		# 比较大小，运算符 -gt；表达式：[ $file_size -gt $BASE_SIZE ]，注意加中括号，注意括号和值之间有空格
        # 注意if-then-fi的逻辑结构
        if [ $file_size -gt $BASE_SIZE ] # 1M
		then 
			val=`expr ${BASE_SIZE} / 1024 / 1024` # 算术运算，除法。
			echo "${FILE_NAMES[i]} is bigger than $val M " 
			rm ${FILE_NAMES[i]}
		fi
	done
  sleep 10 # 10 S
done
```