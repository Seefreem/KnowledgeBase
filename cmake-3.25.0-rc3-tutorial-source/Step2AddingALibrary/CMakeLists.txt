cmake_minimum_required(VERSION 3.10)

    # set the project name and version
project(Tutorial VERSION 1.0)

    # specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

    # TODO 7: Create a variable USE_MYMATH using option and set default to ON
# set(USE_MYMATH ON)
# option(USE_MYMATH "use my math? (Y/N)")
    # 上面的方法也是可以的，注意option中的提示字符串是不会打印到命令行界面的
option(USE_MYMATH "Use tutorial provided math implementation" ON)
    # USE_MYMATH的值将存储在cash中，下次继续使用，要进行修改就在编译指令后添加  -DUSE_MYMATH=OFF如：
    # cmake ../Step2 -DUSE_MYMATH=OFF 注意多了一个D
if (USE_MYMATH)
    add_subdirectory(MathFunctions)
    list(APPEND EXTRA_LIBS MathFunctions)
    list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
    # list() 创建了一个列表，APPEND 表示往列表中添加元素，EXTRA_LIBS 是列表名，后面的则是添加的元素。
endif()

    # configure a header file to pass some of the CMake settings
    # to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

    # TODO 8: Use list() and APPEND to create a list of optional libraries
    # called  EXTRA_LIBS and a list of optional include directories called
    # EXTRA_INCLUDES. Add the MathFunctions library and source directory to
    # the appropriate lists.
    #
    # Only call add_subdirectory and only add MathFunctions specific values
    # to EXTRA_LIBS and EXTRA_INCLUDES if USE_MYMATH is true.

    # TODO 2: Use add_subdirectory() to add MathFunctions to this project
#add_subdirectory("${PROJECT_BINARY_DIR}/../MathFunctions")
    # 可以简写为 add_subdirectory(MathFunctions) 
    # 上述命令指定需要编译的子目录。子目录中需要有自己的CMakeLists.txt
    # 注意如果使用相对路径的话，应该使用相对于 cmake 命令的执行路径的相对路径
include_directories("${CMAKE_CURRENT_BINARY_DIR}/../MathFunctions")
    # 上述命令指定源文件的头文件搜索空间，注意不是可执行文件的头文件搜索空间。

    # add the executable
add_executable(Tutorial tutorial.cxx)

    # TODO 9: Use EXTRA_LIBS instead of the MathFunctions specific values
    # in target_link_libraries.

    # TODO 3: Use target_link_libraries to link the library to our executable

    # TODO 4: Add MathFunctions to Tutorial's target_include_directories()
    # Hint: ${PROJECT_SOURCE_DIR} is a path to the project source. AKA This folder!

    # TODO 10: Use EXTRA_INCLUDES instead of the MathFunctions specific values
    # in target_include_directories.

    # add the binary tree to the search path for include files
    # so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           ${EXTRA_INCLUDES}
                           )

target_link_libraries(Tutorial
                      ${EXTRA_LIBS}
                    )
message ("PROJECT_SOURCE_DIR is " ${PROJECT_SOURCE_DIR})
    # PROJECT_SOURCE_DIR is /home/seelur/git/KnowledgeBase/cmake-3.25.0-rc3-tutorial-source/Step2
    # PROJECT_SOURCE_DIR 是最近一次调用 project() 函数的目录，子目录中的调用不冲突。
