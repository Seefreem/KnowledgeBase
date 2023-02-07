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
