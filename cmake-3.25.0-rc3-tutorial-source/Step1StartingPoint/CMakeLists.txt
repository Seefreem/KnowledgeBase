    # TODO 1: Set the minimum required version of CMake to be 3.10
cmake_minimum_required( VERSION 3.10 FATAL_ERROR)

    # The FATAL_ERROR option is accepted but ignored by CMake 2.6 and higher. 
    # It should be specified so CMake versions 2.4 and lower 
    # fail with an error instead of just a warning.
    # FATAL_ERROR 表示致命错误，也就是在低版本中，将警告视为错误。


    # TODO 2: Create a project named Tutorial
    # project(Tutorial)
    # 定义版本号
project(Tutorial VERSION 1.0)
    # 上面这句命令同时定义了 Tutorial_VERSION_MAJOR 和 Tutorial_VERSION_MINOR两个变量


    # TODO 7: Set the project version number as 1.0 in the above project command
configure_file( TutorialConfig.h.in TutorialConfig.h)
    # 上面这行代码从模板文件（输入文件）中复制内容，并替换其中的部分内容，然后创建并写入新文件（输出文件）

    # include_directories(${CMAKE_CURRENT_BINARY_DIR})
    # 上述命令指定源文件的头文件搜索空间，注意不是可执行文件的头文件搜索空间。
message("CMAKE_CURRENT_BINARY_DIR is " ${CMAKE_CURRENT_BINARY_DIR})
    # 上面这行代码实现 cmake 输出信息到命令行 
    # CMAKE_CURRENT_BINARY_DIR is /home/seelur/git/KnowledgeBase/cmake-3.25.0-rc3-tutorial-source/Step1/build
    # CMAKE_CURRENT_BINARY_DIR 是 cmake 的执行目录，也是cmake的输出目录

    # TODO 6: Set the variable CMAKE_CXX_STANDARD to 11
    #         and the variable CMAKE_CXX_STANDARD_REQUIRED to True
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
    # set(变量名 值)用于定义变量
    # 以“CMAKE_”开头的变量一般是CMake内定的变量，或者内部程序可以直接读取的变量。
    # 通过上面两行限定C++版本，并且这两行应该在 add_executable()之前。


    # TODO 8: Use configure_file to configure and copy TutorialConfig.h.in to
    #         TutorialConfig.h
    # 这里实现的功能是将CMake文件中的变量的值传递到C++源文件中，通过一个配置头文件。


    # TODO 3: Add an executable called Tutorial to the project
    # Hint: Be sure to specify the source file as tutorial.cxx
add_executable(
    Tutorial
    
    tutorial.cxx
)
    # add_executable 实现了编译过程


    # TODO 9: Use target_include_directories to include ${PROJECT_BINARY_DIR}
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )        
    # 上面这行代码的功能是指定比编译之后产生的可执行文件的头文件搜索空间。
    # 这行指令需要在 add_executable 之后，因为这个指令执行的是可执行文件的头文件搜索路径。
    # the project build and the project binary directory 可以是不同的路径。

message("PROJECT_BINARY_DIR is " ${PROJECT_BINARY_DIR})
    # PROJECT_BINARY_DIR is /home/seelur/git/KnowledgeBase/cmake-3.25.0-rc3-tutorial-source/Step1/build/test


