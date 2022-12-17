

安装ros包：
sudo apt-get install ros-noetic-PACKAGENAME
注意根据ros版本修改上述命令。

map server教程：
http://t.zoukankan.com/flyinggod-p-10795457.html

rviz教程：
https://www.shuzhiduo.com/A/VGzlPQkOzb/


创建ros环境：
mkdir -p ./catkin_ws/src
cd ./catkin_ws/
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3


编译错误解决指南：
https://blog.csdn.net/qq_59475883/article/details/123269354
https://blog.csdn.net/BIT_HXZ/article/details/123908947
https://blog.csdn.net/m0_56451176/article/details/126369686
请完全阅读这三个网站之后在解决问题。
我安装的ros是catkin，在/opt/ros/下是 noetic/
所以我遇到：
Could not find a package configuration file provided by "rospy" with any of
  the following names:

    rospyConfig.cmake
    rospy-config.cmake

这写问题时，我是采用下面的安装命令：
sudo apt-get install ros-noetic-rospy
同样还找不到其他的package的时候，就执行：
sudo apt-get install ros-noetic-你缺少的内容


ROS使用方法：
首先要创建dir，并且初始化ros环境：
如：
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

然后sorce一下：
$ source devel/setup.bash

然后才能使用roscore之类的内容。
并且对每一个终端都需要进行一样的操作。


