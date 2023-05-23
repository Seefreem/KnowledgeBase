# Table of Contents

[commond](#commonds-list)

[variables](#variables-list)

# commonds list
https://cmake.org/cmake/help/latest/manual/cmake-commands.7.html

# variables list
https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html

# add_definitions() and add_compile_definitions()
C++源码中怎么获得CMakeList文件中的宏定义 OR 如何在cmakelists文件中设置debug和release 选择性编译源码文件中的内容 OR
CMakeList文件传递宏定义到源文件。
这样做的好处就是，能够选择编译源码中的部分内容，比如日志打印，或者调试代码，以及负责测试的源文件。
还能配合使用abort，assert等调试代码。在debug的时候打开，在release的时候关闭。

用法：
add_definitions() command requires the -D flag be prepended to each definition. 版本3.15以下的Cmake
    add_definitions(-DSOME_BOOL_VARIABLE) 

add_compile_definitions() command (available in CMake 3.15 and above) is cleaner, and does not require the -D flag prefix.
    add_compile_definitions(SOME_BOOL_VARIABLE)

实例：
CMakeList.txt:
    if(${SOME_BOOL_VARIABLE} STREQUAL on)
        add_compile_definitions(SOME_BOOL_VARIABLE)
    endif()
    add_executable(cmake_demo main.cpp)

源文件:
    #include <iostream>
    int main() {
        #ifdef SOME_BOOL_VARIABLE
        std::cout << "SOME_BOOL_VARIABLE marco is define\n";
        #else
        std::cout << "SOME_BOOL_VARIABLE marco is not define\n";
        #endif        
        return 0;
    }

其他：If you are refactoring your code, modern CMake encourages a target-centric approach. Whenever possible, you should prefer the target_compile_definitions() command to add preprocessor definitions to only those targets that require them.
    target_compile_definitions(MyLibraryTarget PRIVATE SOME_BOOL_VARIABLE)

参考链接：
https://blog.csdn.net/uestcyms/article/details/123015158
https://stackoverflow.com/questions/61250087/backward-compatible-add-compile-definitions
https://cmake.org/cmake/help/v3.10/command/add_definitions.html
https://cmake.org/cmake/help/v3.12/command/add_compile_definitions.html
https://cmake.org/cmake/help/latest/command/target_compile_definitions.html

# 区分编译系统，区分系统，系统特异化编译
方式1：
```c
if ("x86_64" STREQUAL ${CMAKE_HOST_SYSTEM_PROCESSOR})
  message("Build on x86_64 platform")
else ()
  message("Build on ARM platform")
endif ()
```
方式2：
```c
MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM}")
 
IF (CMAKE_SYSTEM_NAME MATCHES "Linux")
	MESSAGE(STATUS "current platform: Linux ")
ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Windows")
	MESSAGE(STATUS "current platform: Windows")
ELSEIF (CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
	MESSAGE(STATUS "current platform: FreeBSD")
ELSE ()
	MESSAGE(STATUS "other platform: ${CMAKE_SYSTEM_NAME}")
ENDIF (CMAKE_SYSTEM_NAME MATCHES "Linux")
 
MESSAGE(STSTUS "###################################")
```
方式3：
```c
IF (WIN32)
	MESSAGE(STATUS "Now is windows")
ELSEIF (APPLE)
	MESSAGE(STATUS "Now is Apple systens.")
ELSEIF (UNIX)
	MESSAGE(STATUS "Now is UNIX-like OS's.")
ENDIF ()
```

# No such file or directory
描述：在使用catkkin_make 编译ros项目的时候，
CMakeLists.txt文件配置感觉没问题，但是编译的时候总是报No such file or directory（找不到msg文件）
实际上是因为编译的时候启动了多线程编译，但是这个程序的依赖又在这个程序编译之后编译。
这就导致找不到file。
解决办法就是使用下面的函数添加依赖：
add_dependencies() 这个函数定义了依赖，从而定义了部分编译顺序。

可以参考：https://blog.csdn.net/KingOfMyHeart/article/details/112983922