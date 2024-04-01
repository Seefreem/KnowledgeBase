
# 安装boost



# 用CMakeList.txt文件导入 boost


# trouble shooting
1 main.cpp:(.text+0x164c): undefined reference to `boost::system::generic_category()'
出现整个错误的原因是link的时候没找到对应的库


修改办法：
看到上面的库是boost下面的system，因此在CMakeList文件中查找这个库：
find_package(Boost COMPONENTS system REQUIRED)

'''Cmake
    find_package(Boost
    [version] [EXACT]      # 可选项，最小版本或者确切所需版本
    [REQUIRED]             # 可选项，如果找不到所需库，报错
    [COMPONENTS <libs>...] # 所需的库名称，比如说. "date_time" 代表 "libboost_date_time"
    ) 
'''
运行完后可以得到很多变量，下面列了一些主要的。
原文链接：https://blog.csdn.net/jinzhu1911/article/details/104940277
'''Cmake
    Boost_FOUND            - 如果找到了所需的库就设为true
    Boost_INCLUDE_DIRS     - Boost头文件搜索路径
    Boost_LIBRARY_DIRS     - Boost库的链接路径
    Boost_LIBRARIES        - Boost库名，用于链接到目标程序
    Boost_VERSION          - 从boost/version.hpp文件获取的版本号
    Boost_LIB_VERSION      - 某个库的版本
'''


# 用boost 读取 ini文件的代码：
CMakeList文件：
'''cmake
cmake_minimum_required( VERSION 3.10 FATAL_ERROR)
project(processAnalysis VERSION 1.0)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
find_package(Threads)
find_package(Boost COMPONENTS regex system REQUIRED) # mark here
if(Boost_FOUND) # mark here
    include_directories(${Boost_INCLUDE_DIRS}) # mark here
    MESSAGE( STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}.")
    MESSAGE( STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}.")
    MESSAGE( STATUS "Boost_LIB_VERSION = ${Boost_LIB_VERSION}.")
endif()

add_executable(
    processAnalysis    
    main.cpp
)
target_include_directories(processAnalysis PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           ${Boost_INCLUDE_DIRS})   # mark here
target_link_libraries(processAnalysis ${CMAKE_THREAD_LIBS_INIT} pthread ${Boost_LIBRARIES}) # mark here

'''

最简单版本：
https://jerryshang.me/cpp-boost-read-ini-file/
'''cpp
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/ini_parser.hpp>

boost::property_tree::ptree pt;
boost::property_tree::ini_parser::read_ini("config.ini", pt);

std::cout << pt.get<std::string>("Section1.Value1") << std::endl;
std::cout << pt.get<std::string>("Section1.Value2") << std::endl;
// Section1.Value2 中的Section1 是 section名，Value2是这个section下的一个key

'''

其他版本：

https://blog.csdn.net/tsxw24/article/details/8688488

# ini配置文件的格式
ini 配置文件中的一个 <key, value> 对和宏定义类似，并且在替换的时候是直接将"="后面的内容都作为value，和宏替换类似。
因此像下面的 <key, value> ：
[section]
factor = 0.1; 单位秒
在读取的时候得到的value实际上是 " 0.1; 单位秒"，虽然 ";" 表示注释，但是它只能用于单独起一行的情况。
如果写错了，可能会得到下面的错误信息：
```markdown
terminate called after throwing an instance of 'boost::exception_detail::clone_impl<boost::exception_detail::error_info_injectorboost::property_tree::ptree_bad_data >'
what(): conversion of data to type "d" failed
bash: line 1: 78343 Aborted (core dumped) rosrun node_vehicle_decision node_vehicle_decision
```
