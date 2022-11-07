  # TODO 4: Update the minimum required version to 3.15
cmake_minimum_required(VERSION 3.15)

  # set the project name and version
project(Tutorial VERSION 1.0)

  # TODO 1: Replace the following code by:
  # * Creating an interface library called tutorial_compiler_flags
  #   Hint: use add_library() with the INTERFACE signature
  # * Add compiler feature cxx_std_11 to tutorial_compiler_flags
  #   Hint: Use target_compile_features()

  # specify the C++ standard
  # set(CMAKE_CXX_STANDARD 11)
  # set(CMAKE_CXX_STANDARD_REQUIRED True)
add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
  # 上面两行代码首先新增了一个接口库，但是接口库并没有实际的代码
  # 接口库的编译属性被指定为真C++11 标准，所以当其他 target 包含当前接口的时候都应该满足这个要求。
  # 这就简化了对每一个 target 设置C++标准的过程，同时允许不同的 target 拥有不同的编译要求。
  # 注意要让其生效，需要在其他的CMakeLists.txt文件中使用 target_link_libraries 函数

  # TODO 5: Create helper variables to determine which compiler we are using:
  # * Create a new variable gcc_like_cxx that is true if we are using CXX and
  #   any of the following compilers: ARMClang, AppleClang, Clang, GNU, LCC
  # * Create a new variable msvc_cxx that is true if we are using CXX and MSVC
  # Hint: Use set() and COMPILE_LANG_AND_ID
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
  # 每一个生成表达式(generator expression)都是一个表达式，是要求值的
  # 生成表达式的模板是 $<>
  # 可能的形式：$<condition:true_string>: 也就是条件表达式，条件为真，返回字符串，反之为空
  # 可能的形式：$<operator:item1, item2>: 也就是一个操作与两个操作数的表达式
  # $<COMPILE_LANG_AND_ID:CXX,MSVC> 的含义如下：
  # Results in 1 when the language used for compilation unit matches language and CMake's 
  # compiler id of the language compiler matches 
  # any one of the comma-separated entries in compiler_ids, otherwise 0. 
  # 翻译一下就是，如果 COMPILE_LANG_AND_ID 是 CXX,MSVC 中的任意一个，那么这个生成表达式的值就是1，否则为0.

  # 参考连接 https://blog.csdn.net/xiaoxiaozengz/article/details/119993262
  # COMPILE_LANG_AND_ID 是什么？在哪里定义的？ 
  # COMPILE_LANG_AND_ID 表示 被编译的代码属于什么编程语言，以及语言的ID，这个在
  # https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html#manual:cmake-generator-expressions(7)
  # 中可以查到

message("gcc_like_cxx " ${gcc_like_cxx})
message("msvc_cxx " ${msvc_cxx})
  # 由于生成表达式要在编译的时候才求值，而build/make之前的属于配置，这时候仅仅是字面值，也就是字符串本身

  # TODO 6: Add warning flag compile options to the interface library
  # tutorial_compiler_flags.
  # * For gcc_like_cxx, add flags -Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused
  # * For msvc_cxx, add flags -W3
  # Hint: Use target_compile_options()
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>"
  "$<${msvc_cxx}:-W3>"
)

  # TODO 7: With nested generator expressions, only use the flags for the
  # build-tree
  # Hint: Use BUILD_INTERFACE

target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)
  # 这个和上面的二选一就可以了
  
  # should we use our own math functions
option(USE_MYMATH "Use tutorial provided math implementation" ON)

  # configure a header file to pass some of the CMake settings
  # to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

  # add the MathFunctions library
if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
endif()

  # add the executable
add_executable(Tutorial tutorial.cxx)

  # TODO 2: Link to tutorial_compiler_flags

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS} tutorial_compiler_flags)

  # add the binary tree to the search path for include files
  # so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
