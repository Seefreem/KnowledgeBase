# 火焰图

火焰图的制作参考资料 https://www.cnblogs.com/conscience-remain/p/16142279.html 

总结：
ubuntu安装：
```shell
sudo apt-get install linux-tools-common linux-tools-"$(uname -r)" linux-cloud-tools-"$(uname -r)" linux-tools-generic linux-cloud-tools-generic

# 录取火焰图代码：
# https://github.com/brendangregg/FlameGraph 
git clone https://github.com/brendangregg/FlameGraph.git
```

验证安装：
```shell
perf -v
```

使用：
根据线程ID进行分析：
```shell
# -F 表示采样频率，后接频率
# -p 表示线程ID，后接线程ID
# -g 表示记录程序的调用栈
# 运行结果将写入 perf.data 文件中
sudo perf record -F 99 -p 90175 -g
```

分析数据，生成火焰图, shell脚本：
```shell
# 解析data：
sudo perf script -i perf.data &> "$1".unfold

# 符号折叠：
./stackcollapse-perf.pl "$1".unfold &> "$1".folded

# 生成svg图：
./flamegraph.pl "$1".folded > "$1".svg

```

查看svg图，直接使用浏览器打开就行。

火焰图的缺点：
火焰图是基于CPU采样来制作的，第一个问题就是，可能会包含很多用户透明的函数的信息。第二个问题就是，针对偶发性或者一次性出现的性能瓶颈难以分析。基于统计的结果会使得偶发性和一次性的性能问题的数据不真实，被平均化了。



# ros性能分析（gazebo）
gazebo自带了一个性能分析工具，但是仅用于gazebo的仿真分析。







