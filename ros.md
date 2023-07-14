

# prompt

现在假设你是一位资深ROS（robot operating system）开工程师，你精通ROS的核心概念、文件系统、软件包的创建、构建和管理，节点、话题、服务和参数的理解和使用，基本的发布者和订阅者以及服务和客户端的编写方法，数据的录制和回放，以及ROS维基和其他外部资源的探索。同时也包括手动创建ROS软件包、自定义消息、使用rosdep安装依赖、在多机器人上使用ROS等方面的知识。此外，了解Stage、TF、PCL with ROS等。对于有需要的开发者还能提供一些外部教程和资源的链接。
现在你将作为一个技术咨询专家，以简洁干练地语言回答我的问题。每一次回答问题都有相应的案例。





# 安装

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

rqt和rviz都是ROS中常用的可视化工具。

rqt是一个基于Qt图形界面工具包的插件化框架，在ROS中用于显示和控制机器人或系统的状态。rqt提供了许多有用的插件，包括日志记录器、控制台、图形化调试器、可视化TF、参数编辑器和消息发送器等。使用rqt可以帮助用户更直观地了解和交互机器人系统。

rviz则是一款用于三维可视化的工具，它可以用于可视化机器人的各种传感器数据、机器人的运动控制和路径规划等等。rviz允许用户通过添加插件来构建机器人的三维模型和环境模型，以进行仿真和可视化。在ROS中，rviz非常流行，不仅适用于工业应用，也用于教育和研究领域。

rqt.perspective是一种保存和加载rqt GUI布局的方法。

在rqt中，用户可以通过拖拽、调整和关闭各种插件来自定义GUI布局，以适应不同的工作场景。然而，在关闭rqt或者重新打开时，这些自定义的GUI布局会丢失。为了避免这种情况发生，rqt提供了一个功能，叫做rqt.perspective。使用rqt.perspective，用户可以通过选择“保存”选项，将当前的GUI布局保存为一个文件，以后可以通过选择“加载”选项，重新加载之前的布局，从而方便用户再次使用之前的自定义GUI布局。

在rqt中，rqt.perspective通常保存为yaml格式的文件，并且文件名以.perspective结尾。例如，如果用户保存名为“my_perspective”的GUI布局，那么相应的文件名应该是“my_perspective.perspective.yaml”。

要加载一个.perspective文件，可以在rqt的菜单栏中选择“Perspective”选项，然后再选择“Load perspective…”（加载perspective）选项。这时会弹出一个文件对话框，用户可以选择需要加载的perspective文件，然后点击“打开”按钮即可。加载成功后，rqt的GUI界面会切换到之前保存的布局。

可以通过在终端输入以下命令来加载perspective文件：

rosrun rqt_gui rqt_gui -perspective-file /path/to/perspective/file.perspective
其中，/path/to/perspective/file.perspective需要替换成perspective文件的实际路径。执行该命令后，rqt会自动打开，并加载指定的perspective文件。


要生成一个.perspective文件，可以按照以下步骤：

打开rqt界面，配置好布局和各个插件的摆放位置和大小；
在rqt的菜单栏中选择“Perspective”选项，然后选择“Save current perspective as…”（保存当前perspective）选项；
在弹出的文件保存对话框中，输入perspective文件的名字和保存路径；
点击“保存”按钮，即可保存当前布局信息为一个.perspective文件。
这样，就生成了一个包含当前rqt界面布局信息的perspective文件。以后可以通过加载该文件来恢复之前保存的界面布局。


要在rqt中加载rviz插件显示机器人的位置，可以按照以下步骤操作：

1. 打开rqt，如果还未安装rviz插件，则需要先安装该插件，在终端中输入以下命令安装：

sudo apt-get install ros-<distro>-rviz
其中，<distro>需要替换成你使用的ROS发行版，比如melodic。

2. 在rqt的菜单栏中选择“Plugins”选项，然后选择“Visualization”>“rviz”选项，即可加载rviz插件；

3. 在rviz插件中，选择“File”>“Open Config”选项，然后选择你想要打开的配置文件；

4. 打开配置文件后，rviz会显示机器人的模型和传感器数据。若rviz中没有展示机器人位置，则需要在TF中设置坐标系，使其能够正确地追踪机器人运动。

这样，就能在rqt中加载rviz插件，并且显示出机器人的位置。


rqt是ROS机器人操作系统提供的一个灵活的图形化工具集，其中包含了许多实用的工具和插件，可以帮助机器人开发者更好地可视化机器人数据、调试机器人程序、管理机器人资源等。下面是rqt最常用的功能：

1. Topic Monitor：话题监视器，用于监测ROS节点之间发布和订阅的话题消息，查看话题消息的内容、类型和频率等信息。可以帮助开发者实时监测机器人状态、调试程序、分析问题等。

2. Bag Player：用于读取ROS的数据记录器bag文件，回放被记录下来的话题消息，以便开发者分析记录下来的数据、调试程序等。

3. Plot：一种可视化工具，用于绘制ROS节点中的数值话题消息，例如机器人传感器的测量数据、控制指令等。开发者可以通过Plot工具进行数据分析、调试程序等。

4. Message Publisher：发布者工具，用于向ROS网络中发布指定的话题消息，可以手动控制终端机器人，以观察其反应；可以控制节点执行各种测试；也可以用于控制机器人执行各种操作。

5. Image View：图像查看器，用于查看机器人传感器获得的图像信息，例如摄像头获取的实时图像、激光雷达获取的点云数据等。

6. Configuration：配置工具，用于配置ROS节点、参数和环境变量等，确保ROS程序的正确运行。

7. Bag Recorder：用于将ROS话题消息记录到数据记录器bag文件中，以便进行调试、重放和分析等。

8. RViz，显示三维模型、机器人、环境地图和传感器数据等，可以用于仿真、虚拟化和测试等。

总之，rqt是ROS机器人操作系统中非常实用和灵活的工具集，通过这些工具和插件的使用，可以方便地查看、分析、调试机器人节点之间的数据交互和程序行为。

rqt的所有功能都是通过各种插件（plugins）实现的。rqt的插件系统非常灵活，支持各种用户自定义的插件开发和添加。

ROS系统中的各个功能单元都是以节点（Nodes）的形式组织起来的，而rqt的各种插件往往是以图形用户界面（GUI）的形式出现，用于可视化这些节点之间的数据交互和状态信息。因此，rqt插件通常会依赖ROS的核心库和API，利用ROS提供的各种工具和算法实现各种功能。

rqt的插件通常是以Python编写的，通过ROS的Python API来操作ROS的数据和节点。当用户需要使用某个插件时，只需在rqt的窗口中选择对应的插件即可，rqt会自动加载该插件并在窗口中显示出来。同时，用户也可以自己编写插件，并添加到rqt的插件列表中，以满足自己的需求。


rviz是ROS中一个非常流行和强大的可视化工具，它提供了一个灵活的三维可视化环境，可以方便地观察和分析ROS系统中的各种数据和状态信息，包括：

1. 3D模型的可视化：rviz支持将ROS系统中的3D模型数据进行可视化，可以方便地观察机器人、传感器等物体的位置、姿态、尺寸等信息。

2. ROS消息的可视化：rviz可以将ROS消息中的数据以各种不同的视图形式进行可视化，例如雷达数据、激光数据、图像数据等等。

3. 机器人路径的规划和展示：rviz可以显示机器人的路径、姿态和速度等信息，还支持机器人的运动控制和路径规划。

4. ROS系统的调试和分析：rviz提供了丰富的调试工具和功能，可以帮助用户检查ROS系统中的错误、性能瓶颈等问题，并提供相应的解决方案。

5. 用户自定义插件：rviz还支持用户自定义插件的开发和添加，可以为用户提供更加灵活和定制化的功能。

总之，rviz在ROS生态中扮演着非常重要的角色，它不仅可以方便地观察和分析各种ROS数据，还可以帮助用户进行系统的调试和优化，提高系统的可靠性和性能。


rviz和rqt在ROS中提供了一些重叠的功能和工具，这是因为它们面向的用户群体和使用场景略有不同。

rviz是ROS中的一个用于可视化机器人三维模型和传感器数据的工具，主要面向机器人领域的用户，常用于机器人开发和调试过程中。rviz提供了强大的可视化功能，可以展示机器人的位姿、运动轨迹、地图等等，还支持各种传感器数据的可视化，例如激光雷达数据、图像数据等等。此外，rviz还支持用户自定义插件的开发，方便用户增加自己想要的特定功能。

rqt则是ROS的图形用户界面工具，提供了一系列工具和插件，用于帮助ROS用户更加方便地进行各种开发、调试和测试任务。rqt的插件类型多样，包括日志查看、控制台、图像显示等等，同时rqt还支持用户自定义插件和布局，可以根据需要灵活调整整个用户界面的布局和功能。




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



  # ROS参数服务器
  ROS参数服务器是默认启动的。是不需要用户编程的。
  用户可以通过终端命令、源代码API、roslaunch等方式去操作参数。
  也可以通过yaml文件去加载参数或参数文件。
  但是在源码API这里，不提供加载参数文件的方法。
  
# roswtf
roswtf是ROS中的一个命令行工具，用于检查ROS系统中是否存在问题。roswtf会执行一系列诊断和测试来检查ROS节点、话题、服务、参数、ROS Graph等方面是否存在问题，可以帮助识别、定位和解决ROS系统的故障。它是一个非常有用的工具，特别是在调试和排除ROS系统问题时。

节点：节点启动失败或崩溃。
场景描述：您正在开发一个ROS节点，但当您尝试启动该节点时，发现该节点启动失败或崩溃，导致无法使用该节点的相关功能。这可能是由于代码错误、依赖项缺失或其他原因导致的。

话题：发布与订阅不一致。
场景描述：您有两个节点，一个发布器和一个订阅器，但是数据没有正确地传输，可能是因为发布器和订阅器的消息类型不一致，或者发布器的发布频率太快导致数据丢失。

服务：请求与响应不一致。
场景描述：您正在使用ROS服务，但是在请求过程中出现了问题。您可能已经向服务发送了请求，但收到的响应却不符合您的预期，可能是由于请求参数不正确或服务器端出现了问题。

参数：参数设置不正确。
场景描述：您在ROS中使用了参数服务器，但是您设置的参数不起作用。这可能是由于参数名称错误、命名空间不正确、数据类型不匹配或其他原因导致的。

ROS Graph：节点通信问题。
场景描述：您有多个节点，但是它们之间无法正确地通信。这可能是由于节点名称、话题名称、服务名称或消息类型存在问题，网络问题或其他原因导致的。

以上是一些常见的ROS系统问题示例，roswtf 可以帮助您识别并解决这些问题。

## 节点
当使用 roswtf 发现节点启动失败或崩溃时，会给出相应的错误代码或日志，示例如下：

WARNING The following node subscriptions are unconnected:
 * /my_node:
   * /my_topic

ERROR Could not contact the following nodes:
 * /my_node

ERROR Errors connecting to the following services:
 * /my_service

ERROR Errors connecting to service [/my_service]:
 * Unable to connect to service [/my_service]
上述示例结果含义为：

节点 /my_node 订阅了一个名为 /my_topic 的话题，但是该话题没有发布器，因此这个节点的消息无法正常接收；
roswtf 无法与节点 /my_node 进行通信；
roswtf 无法使用服务 /my_service 进行连接；
使用服务 /my_service 时出现错误无法连接。
根据提示信息，您可以进一步排除问题并修复节点启动失败或崩溃的原因。

## 话题
当使用 roswtf 发现话题发布与订阅不一致时，会给出相应的提示信息，示例如下：

WARNING The following node subscriptions are unconnected:
 * /my_node:
   * /my_topic

WARNING The following node is attempting to subscribe to a topic that is not being published:
 * /my_node:
   * /my_topic
上述示例结果含义为：

节点 /my_node 订阅了一个名为 /my_topic 的话题，但是该话题没有发布器，因此这个节点的消息无法正常接收；
节点 /my_node 尝试订阅了一个不存在的话题 /my_topic。
根据提示信息，您可以进一步排除问题并修复话题发布与订阅不一致的原因。

## 服务
当使用 roswtf 发现服务请求与响应不一致时，会给出相应的提示信息，示例如下：

WARNING The following service request types do not match:
 * /my_service:
   * Request message type [std_srvs/SetBoolRequest]
   * Registered service type [std_srvs/Trigger]

WARNING The following service response types do not match:
 * /my_service:
   * Response message type [std_srvs/SetBoolResponse]
   * Registered service type [std_srvs/Trigger]
上述示例结果含义为：

服务 /my_service 所注册的请求消息类型为 std_srvs/Trigger，而节点 /my_node 发送的请求消息类型为 std_srvs/SetBoolRequest，两种消息类型不一致；
服务 /my_service 所注册的响应消息类型为 std_srvs/Trigger，而节点 /my_node 期望接收的响应消息类型为 std_srvs/SetBoolResponse，两种消息类型不一致。
根据提示信息，您可以进一步排除问题并修复服务请求与响应不一致的原因。

## 参数
当使用 roswtf 发现参数设置不正确时，会给出相应的提示信息，示例如下：

ERROR The following parameters are set but not used:
 * /my_node/my_parameter

ERROR The following parameters are needed but not set:
 * /my_node/required_parameter
上述示例结果含义为：

节点 /my_node 设置了一个名为 /my_parameter 的参数，但是该参数并未在节点代码中被使用；
节点 /my_node 需要一个名为 /required_parameter 的参数，但是该参数并未被设置。
根据提示信息，您可以进一步排除问题并修复参数设置不正确的原因。

## ROS Graph
当使用 roswtf 发现节点通信问题时，会给出相应的提示信息，示例如下：

ERROR Could not contact the following nodes:
 * /node2
 * /node3

ERROR Topics [/topic1, /topic2] are not connected. 
上述示例结果含义为：

当前节点无法联系到节点 /node2、/node3，可能是因为这些节点没有运行，或者因为网络或防火墙配置问题而无法访问；
主题 /topic1 和 /topic2 没有建立连接，可能是因为没有正在发布或订阅该主题的节点或者因为网络或防火墙配置问题而无法访问。
根据提示信息，您可以进一步排除问题并修复节点通信问题的原因。

# 对分布式系统的支持

ROS_MASTER_URI 是ROS的一个环境变量，用于指定ROS的主节点（roscore）的URL地址。主节点负责协调ROS系统中各个节点之间的通信。这个环境变量告诉ROS节点们需要连接哪个主节点。

对于ROS分布式系统，如果各个节点不在同一台计算机上，则需要在不同的计算机上设置不同的 ROS_MASTER_URI，以便让节点能够正确地连接到主节点并协同工作。

默认情况下，ROS_MASTER_URI 的值为 http://localhost:11311，即主节点和所有节点都在同一台计算机上。如果您的主节点在另一台计算机上，则需要设置正确的主节点的 IP 地址和端口号。

假设主节点的IP地址为 192.168.1.100，端口是11311，那么可以通过以下命令来设置 ROS_MASTER_URI：

export ROS_MASTER_URI=http://192.168.1.100:11311
您可以将此命令添加到 .bashrc 文件中，这样每次打开终端时都会自动启动。或者，也可以通过在 ROS launch 文件中设置 remap 元素的方式，来覆盖环境变量的值。


当您在使用 roslaunch 来启动 ROS 节点时，可以使用 arg 和 param 元素来设置 ROS_MASTER_URI。

以下是设置 ROS_MASTER_URI 的示例 roslaunch 文件：

<launch>
  <!-- 设置 ROS_MASTER_URI -->
  <arg name="ros_master_uri" default="http://192.168.1.100:11311"/>

  <!-- 启动节点并使用指定的 ROS_MASTER_URI -->
  <node name="my_node" pkg="my_package" type="my_node_type"
        args="--ros-args --remap=/rosout:=/my_node/rosout"
        env="PYTHONUNBUFFERED=1" output="screen">
    <param name="ros_master_uri" value="$(arg ros_master_uri)"/>
  </node>
</launch>
在此示例中，arg 元素用于定义一个名为 ros_master_uri 的参数，并将其默认值设置为 http://192.168.1.100:11311。此参数将作为节点的 ROS_MASTER_URI。然后，使用 param 元素在节点中设置 ros_master_uri 的值为 $(arg ros_master_uri)。这将覆盖默认值，并将节点连接到指定的主节点。

注意，这个示例中也使用了 args 元素来定义节点的一些命令行参数，并使用 env 元素来设置环境变量。这些元素都是可选的，只是为了说明可以在 node 元素中添加其他选项。
<arg> 和<param> 是简化和参数化ROS launch文件的两个元素。它们可以用于向ROS launch文件里的其他元素传递参数值和设置参数的默认值，以便launcher可以在启动节点之前对它们进行修改。具体而言：

在 <arg> 元素中，name 属性定义了参数的名称，default 属性定义了默认值。您可以通过在命令行或其他方式中指定参数值来覆盖默认值，例如 roslaunch my_package my_node.launch ros_master_uri:=http://192.168.1.111:11311，其中 ros_master_uri 就是一个参数名。

在 <param> 元素中，name 属性定义了节点参数的名称，value 属性定义了该参数的值。您可以在这里使用 $() 语法来使用先前定义的 <arg> 元素并将其导入到节点参数中。例如 <param name="ros_master_uri" value="$(arg ros_master_uri)"/> 表示将在这个节点里使用 <arg> 元素中定义的 ros_master_uri 参数。

在上面提供的示例中，<arg> 元素的默认值为 http://192.168.1.100:11311。如果没有其他任何指定，程序将默认使用这个地址作为 ROS master node 的地址。使用 $(arg ...) 语法通过 <param> 设置 ros_master_uri 的值，从而使节点使用传递给 roslaunch 命令的参数来更改 ROS master node 的地址。

综上所述，<arg> 和 <param> 元素可以帮助您传递参数和设置默认值，以便使您的 ROS launch 文件更加灵活和可配置。


* 也就相当于param 是在一个节点的命名空间中的，而arg是一个公用的参数，对吗?

是的，您可以将 <arg> 看作是用于在 <launch> 文件范围内定义参数的元素，<param> 则用于在一个给定节点的命名空间内定义参数的元素。在ROS中，命名空间类似于文件系统中的路径，每个节点都有自己的命名空间。通过在命名空间中定义参数，可以限制参数的范围，并将其与该命名空间下的其他节点隔离开来。

例如，在前面提到的示例中，我们使用 <param> 元素在名为 my_node 的节点中定义了 ros_master_uri 参数。这个节点有自己的命名空间，因此任何与该命名空间相关的其他节点都可以直接访问该参数。其他节点可以通过命名空间限定来定义自己的参数，从而在功能上与此节点相互独立。

另一方面，可以在 <launch> 文件范围内定义 <arg> 元素，以便对其进行全局使用。这些参数在整个启动文件中都是可见的，并且可以通过在 <param> 内指定使用 $() 语法来将参数传递给任意节点。

因此，<arg> 和 <param> 的目的是相同的，即提供一种灵活的机制来传递或设置命令行参数和节点参数，但它们的用途略有不同，并且可用于不同的应用程序场景。

# 节点命名空间
rosmaster和ros node都可以有命名空间。

对于多机协作或者云-端协同的情况，我们希望多个机器之间能够通过ROS的话题进行通信，但是存在一个网络传输延迟的问题。
因此，如果ROSmaster不在本机上运行，那么本机接收到任何topic话题都很慢。

于是ROSmaster的命名空间就发挥作用了，简单来说就是，在每一台机器上都启动一个ROSmaster，每个ROSmaster都会有一个URI，在运行roscore的时候就会打印到终端。本机上的节点可以选择本机的URI进行链接，从而本机上的节点之间的信息传输就很快。然后可以建立单独的节点去与其他机器的ROSmaster进行通信（中间件）。

另外，还有一种情况是，在搭建仿真平台的时候，我们可能想要在一套机器上运行一份代码的多个实例，从而模拟多台机器，那么这时候由于每台模拟机器都使用同样的代码，所以发布的消息也是一样的，这就导致了信息混乱。为了避免这种问题，节点的命名空间就起作用了。
节点在发布和订阅的时候都可以指定命名空间(同时还需要指定端口号和ID)：
```
gnome-terminal --title="truck_9" --tab -x bash -c -- "
source devel/setup.bash
rosrun node_vehicle_decision node_vehicle_decision _local_port:=8882 _local_id:=1008 __ns:=/truck_9 truck_9; exec bash
```
