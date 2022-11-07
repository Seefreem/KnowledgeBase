cmake_minimum_required(VERSION 3.15)

  # set the project name and version
project(Tutorial VERSION 1.0)

  # specify the C++ standard
add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)

  # add compiler warning flags just when building this project via
  # the BUILD_INTERFACE genex
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

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
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS} tutorial_compiler_flags)

  # add the binary tree to the search path for include files
  # so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

  # TODO 3: Install Tutorial in the bin directory
  # Hint: Use the TARGETS and DESTINATION parameters
install(TARGETS Tutorial DESTINATION bin)
  # TODO 4: Install Tutorial.h to the include directory
  # Hint: Use the FILES and DESTINATION parameters
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" 
        DESTINATION include)
  # DESTINATION 的默认前缀是 /usr/local/

  # TODO 5: Enable testing
enable_testing()
  # TODO 6: Add a test called Runs which runs the following command:
  # $ Tutorial 25
add_test(NAME runs COMMAND Tutorial 25)
  # add_test(NAME 这次测试的名称(测试变量) COMMAND 测试命令)
  # “这次测试的名称” 是一个自定义的名字，作用类似于变量，可以通过这个
  # 变量为这次测试添加属性。

  # TODO 7: Add a test called Usage which runs the following command:
  # $ Tutorial
  # Make sure the expected output is displayed.
  # Hint: Use the PASS_REGULAR_EXPRESSION property with "Usage.*number"
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )
  # PASS_REGULAR_EXPRESSION 属性是用于检测 target 的输出中是否包含某个字符串
  # 在这里，就是检测输出中是否包含 "Usage:.*number" 这个字符串，字符串中使用了通配符。

  # TODO 8: Add a test which runs the following command:
  # $ Tutorial 4
  # Make sure the result is correct.
  # Hint: Use the PASS_REGULAR_EXPRESSION property with "4 is 2"
add_test(NAME StandardUsage COMMAND Tutorial 4)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "4 is 2"
  )
  # 检测输出中是否包含字符串 "4 is 2"

  # TODO 9: Add more tests. Create a function called do_test to avoid copy +
  # paste. Test the following values: 4, 9, 5, 7, 25, -25 and 0.00001.
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(
    Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
  )
endfunction()
  # 上面定义了一个CMake函数，CMake的作用域和Python类似，都是通过缩进来表示的

# do a bunch of result based tests
# 添加一系列的测试项目
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")

  # 运行测试脚本：
  # 1 编译项目
  # 2 在终端输入:
  #   ctest -vv：输出测试结果的简略信息
  #   ctest -VV：输出测试结果的详细信息
  #   ctest -N：输出测的数目以及每个测试的名
  #   ctest：等效于 ctest -vv

  