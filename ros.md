

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
首先要创建dir，并且初始化ros环境(不用手动去创建CMakeLists.txt等文件)：
如：
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

然后sorce一下：
$ source devel/setup.bash

然后才能使用roscore之类的内容。
并且对每一个终端都需要进行一样的操作。


# roslaunch
https://zhuanlan.zhihu.com/p/107121741
http://wiki.ros.org/cn/ROS/Tutorials/UsingRqtconsoleRoslaunch

roslaunch 是rosrun的另一种执行方式，可以批量化执行rosrun，还可以执行其他ros节点，如rviz。

roslaunch 的作用就是：
  启动多个节点
  在参数服务器设置参数
  可自动重启节点
  自动启动 roscore

启动命令是：roslaunch package_name file.launch


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
  http://wiki.ros.org/rviz/DisplayTypes/Marker
  https://github.com/ipa320/accompany/blob/master/accompany_uva_msg/src/MsgToMarkerArray.cpp

==代码没问题但是就是没显示
  这种请款可能是你的数据值有问题，比如坐标超出了画面、size太小，看不见等。


# roscpp logging
http://wiki.ros.org/roscpp/Overview/Logging
https://wiki.nps.edu/display/MRC/Setting+Logging+Level
https://blog.csdn.net/Nicholasoooo/article/details/117920615
https://blog.csdn.net/irving512/article/details/120055560

构建最基本的roslogging代码：
S1 构建 package：
  catkin_create_pkg <package name>  std_msgs rospy roscpp
  但要注意package 之间不能嵌套，也就是在一个package 中，不能再创建另一个package ，所有package 都必须是相对独立的目录。
S2 编辑CMakeLists.txt 文件
S3 创建CPP文件
    #include "ros/ros.h"
    #include "std_msgs/String.h"
    int main(int argc, char **argv) {
      ros::init(argc, argv, "n_crossroads_controll");
      ros::NodeHandle n;
      ros::Publisher chatter_pub = n.advertise<std_msgs::String>("n_crossroads_controll", 1000);
      ros::Rate loop_rate(10);
      int count = 0;
      while (ros::ok()) {
        ROS_INFO("%d", count++);
        loop_rate.sleep();
      }
      return 0;
    }
S4 编译运行

默认情况下 日志存储在 ~/.ros/log/目录下

==自定义配置文件：
但是要注意，自定义的功能似乎在melodic中不可用。
命令行配置的 export ROSCONSOLE_FORMAT='[${severity} ${time}]: ${message}'
打印出来的是 [ ]: 这种信息


# rosbag filter
过滤rosbag。
```sh
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
```
单独录制这三个话题数据的话：
  rosbag record /msg_v_state /msg_obj_fuse /msg_info_router

# ros消息，ros::msg，自定义ros消息
http://wiki.ros.org/cn/ROS/Tutorials/CreatingMsgAndSrv
http://wiki.ros.org/cn/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29
https://robot.czxy.com/docs/ros/msg/def/

思路：
首先创建消息文件：msg/Num.msg
然后依次修改下列的文件：
源码文件夹下的：
  package.xml：
    添加 ：
    <build_depend>message_generation</build_depend>
    <exec_depend>message_runtime</exec_depend>
  CMakeLists.txt：
    添加：
    find_package(catkin REQUIRED COMPONENTS
      roscpp
      rospy
      std_msgs
      message_generation
    )

msg目录下的（.msg文件会被编译成package）：
  CMakeLists.txt：
    添加：
    catkin_package(
    ...
    CATKIN_DEPENDS message_runtime ...
    ...)

    add_message_files(
      FILES
      xxx.msg # 你自定义的.msg文件
    )

ROS的消息机制是发布订阅者模式，因此发布者和订阅者属于完全解耦。
如何基于ROS的发布订阅者模式实现消息/事件的消费？
在订阅的时候，有三个订阅的重载，回调函数有三种方式接受消息：复制、指针和常量指针。
并且ROS的subscribe拿到的是消息的常量指针。

为了实现消息/事件的消费功能，那么就接受消息的指针。本地定义的变量也是消息的指针变量。
当完成对消息的消费之后，就将指针定义为空。这样就能省略一些表质量。


# ros可视化
https://www.guyuehome.com/34172

可视化话题数据：
rosrun rqt_plot rqt_plot   #画出发布在topic上的数据变化图

可视化node关系图：
rosrun rqt_graph rqt_graph   #画出node关系图

日志可视化：
rosrun rqt_console rqt_console #属于ROS日志框架(logging framework)的一部分，用来显示节点的输出信息

rosrun rqt_logger_level rqt_logger_level #允许我们修改节点运行时输出信息的日志等级（logger levels）

tf框架树可视化：
rosrun rqt_tf_tree rqt_tf_tree #实时监控坐标系收听关系的工具，点击refersh来刷新

图像可视化：
rosrun image_view image_view image:=/camera#使用image_view在窗口中展示给定主题的图像，还可以通过图形界面上的按钮将图片保存到硬盘里
rosrun rqt_image_view rqt_image_view#使用rqt_image_view，还可以在一个窗口中查看多个图像

日志可视化：

rosrun uvc_camera uvc_camera_node

rosbag record -a #记录所有的主题
rosbag record /image_raw #记录特定的主题 
rosbag info 消息记录文件.bag#看到创建的日期、 持续时间、文件大小， 以及内部消息的数量和文件的压缩格式（如果有压缩） 。 然后， 我们还会有文件内部数据类型的列表。 最后有主题的列表， 并它们对应的名称、 消息数量和类型。

rqt_bag <your bagfile> #实时显示相机的bag包

话题频率可视化：
rosrun rqt_topic rqt_topic#topic发布频率

配置参数可视化：
rosrun rqt_reconfigure rqt_reconfigure#手动调节ros的topic参数
#您也可以通过rqt_gui启动reconfigure_gui：
rosrun rqt_gui rqt_gui

其他可视化。



# ROS的消息通信机制
1 消息是在什么时候被消费的？
  消息的消费动作是订阅者的spin/spinOnce函数。
  如果消息的队列设置得大于等于1，并且消费频率低于发布频率，
  那么消息就会在消息队列中排列，并且在消费时会一次性将所有缓存的消息消费掉。

2 当订阅者的频率大于发布频率时：
  那么订阅者的回调函数频率会和发布频率一致。
  也就是说当发布者没有发布消息的时候，订阅者的spin函数并不会获取到信息，回调函数也不会执行。


3 由于ROS的通信方式是发布订阅者模式，发布者和订阅者是完全解耦的，因此完全可以让一个节点自己订阅自己发布的话题。
  换句话说就是，如果某个节点自己发布的话题和订阅的话题一致的话，它就会收到自己发布的消息。这可能导致一些问题。