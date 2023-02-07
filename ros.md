

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


# rviz
==xxx.rviz文件
  是在关闭rviz时，提示你是否保存时，当你点击保存之后产生的文件。同理，当你修改了rviz中的某些话题、视图、面板等，你保存之后，下次打开就会是你上次保存的模样。

==rviz能够自动检测到话题，只要话题的内容是rviz能够解析的，那么就能在rviz中选择订阅。并且显示到rviz中。这种可拓展性还真是设计得很好。

==visualization_msgs/MarkerArray & visualization_msgs/Marker：
  一种用于显示各种图像集合的显示类型。
  visualization_msgs/MarkerArray 是 visualization_msgs/Marker 的 vector版本。
  visualization_msgs/MarkerArray中的属性 markers 的定义如下：
  std::vector<visualization_msgs::Marker, std::allocator<visualization_msgs::Marker>> visualization_msgs::MarkerArray::markers

  参考代码：
  http://docs.ros.org/en/diamondback/api/rviz/html/marker__test_8cpp_source.html
  https://github.com/ipa320/accompany/blob/master/accompany_uva_msg/src/MsgToMarkerArray.cpp

==代码没问题但是就是没显示
  这种请款可能是你的数据值有问题，比如坐标超出了画面、size太小，看不见等。
