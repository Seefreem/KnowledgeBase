

# 一个比较有趣的培训网站
https://robot.czxy.com/


# Euclidean distance 
[juːˈklɪdiən] 
欧氏距离

# 构形空间/configuration space/C-space/膨胀障碍物之后的地图
https://www.cnblogs.com/21207-iHome/p/7756084.html

# non-holonomic
[hɑːloʊˈnɑːmɪk] 
holonomic 用于机器人时，是指机器人的自由度和关节数目一致的情况。
non-holonomic 则表示机器人的自由度和关节数目不一致。

# 车辆模型
==单车模型 bicycle model
https://blog.csdn.net/u010241908/article/details/123328550

==运动学模型 kinematic model [ˌkɪnəˈmætɪk] 
https://zhuanlan.zhihu.com/p/153533035

==动力学模型 dynamic model
https://zhuanlan.zhihu.com/p/153533035

# Dubins曲线(Dubins path, Dubins curve)
https://blog.csdn.net/u010241908/article/details/123328550
https://zhuanlan.zhihu.com/p/414753861
Dubins 曲线是在无障碍的情况下，提供一条最优的前向路径，
与A* ，RRT等那些搜索算法相比，还有一个优势就是规划的路径是满足车辆运动学要求的。
也就是一个路径规划算法。
motion primitive [ˈprɪmətɪv]: 基本运动

# Reeds-Shepp曲线(RS曲线, reeds-shepp path, reeds-shepp curve)
https://blog.csdn.net/u010241908/article/details/123328550
比于Dubins曲线只允许车辆向前运动，Reeds Shepp曲线运动模型既允许车辆向前运动，也允许车辆向后运动。
从起点q_{I}到终点q_{G}的最短路径组成一个 word。
每个world都由L^{+}，L^{-}，R^{+}，R^{-}，S^{+}，S^{-}这六种primitives组成，
其中，L^{+}表示车辆左转前进；L^{-}表示车辆左转后退；R^{+}表示车辆右转前进；
R^{-}表示车辆右转后退，S^{+}表示车辆直行前进；S^{-}表示车辆直行后退。
C_{\beta }表示两个曲线长度一样的曲线部分，C_{\pi /2}表示曲线部分有90度。

一般在计算之前，会将车辆的姿态归一化。假设车辆的初始姿态为q_{I}=(x_{1},y_{1},\theta _{1})，
目标姿态为q_{G}=(x_{2},y_{2},\theta _{2})，车辆的半径为r=\rho。
归一化的过程就是向量的平移和旋转的过程，使得变换后的起始位姿q_{I}=(0,0,0)，
目标姿态为q_{G}=(x,y,\phi )，车辆的转弯半径r=1。

可以利用其对称性降低求解工作量。

# 维诺(Voronoi)地图(Voronoi diagram, Dirichlet diagram)
https://blog.csdn.net/u010241908/article/details/123328550
维诺地图是一种对距离地图的扩展。通过距离地图和广义泰森多边形(generalized Voronoi diagram，GVD)相结合所形成。
它是由一组由连接两邻点直线的垂直平分线组成的连续多边形组成。
特点：
（1）每个V多边形内有一个生成元；
（2）每个V多边形内点到该生成元距离短于到其它生成元距离；
（3）多边形边界上的点到生成此边界的生成元距离相等；
（4）邻接图形的Voronoi多边形界线以原邻接界线作为子集。


# 地图
常用的地图有距离地图、栅格地图和维诺地图等。
距离地图：距离地图是在规划算法进行搜索过程中提供扩展节点到障碍物的最近距离。其中，最近距离是通过欧式距离所计算得到。
栅格地图：
维诺地图：维诺地图是一种对距离地图的扩展。通过距离地图和广义泰森多边形(generalized Voronoi diagram，GVD)相结合所形成。


# 自由度
自由度的定义为：描述空间运动的刚体所需要的独立变量的个数（最大为6）
在构成机构的要素中，不存在相对运动的部分称为构件（link），两个以上构件相互约束且能够相对运动时，就形成了运动副（pair）。
在机械手中，运动副被称为关节，包括移动关节、转动关节、圆柱关节、（半）球关节等，其自由度分别为1(距离)、1(角度)、2(角度和高度)、2(经纬)。

不受外部约束的刚体具有 6 个自由度。当刚体的位置、姿态和运动在三维空间中用直角坐标来表示时，
6 个自由度分别为 x 轴、y 轴、z 轴三个自由度，绕各轴的三个旋转自由度 α、β、γ（称为Roll，Pitch，Yaw）。
Roll(rolling)：翻滚(侧向滚动)
Pitch(pitching)：俯仰(前后俯仰)
Yaw(yawing)：偏航(左右航向)

扫地机在大部分情况下具有三个自由度：x、y和yawing。但是在做打滑检测的时候使用了5个自由度(x, y, rolling, pitching and yawing)。
一般的移动机器人可以只用三个自由度进行运动学建模，分别是(x, y, theta)，表示位姿。
并且运动学方程也比较简单。分别建立在三个轴上的速度方程(坐标对时间的导数)。

# 坐标系
==世界坐标系：固定在地面上的坐标系称为世界坐标系(ground coordination)。
==基础坐标系：固定在安装面上的坐标系称为基础坐标系。
  对于固定安装的机器人，当安装完成后，坐标系之间的对应关系即唯一确定，两种坐标系之间的变换很容易进行。
==接口坐标系：固定在安装末端执行器的机械接口处，称为机械接口坐标系（mechanical interface）
==末端执行器坐标系：末端执行器坐标系。末端执行器安装在接口处。

# 库

## QPOASES
QPOASES 是为解决MPC问题所编写的库，用户可将MPC问题转化为序列二次规划问题(SQP)后用该库进行求解，同时其也可以解决单独的QP优化问题。

# 算法
## OBB 
OBB 即 oriented bounding box（方向包围盒），用来抽象化复杂几何图形，以简化碰撞检测。

## MPC
模型预测控制（Model Predictive Control）指一类算法，周期性基于当帧测量信息在线求解一个有限时间开环优化问题，并将结果的前部分控制序列作用于被控对象。根据所用模型不同，分为动态矩阵控制（DMC），模型算法控制（MAC）、广义预测控制（GPC）。在智能驾驶方向，重点在于基于状态空间模型的模型预测控制。



