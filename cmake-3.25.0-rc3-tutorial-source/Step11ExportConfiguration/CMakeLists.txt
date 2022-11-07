# 着一个例子是导出配置文件，其作用似乎是让别人能够将我们的项目编译到
# 他们的项目中。如果不导出这些文件，别人就不能通过 find_package() 来使用我们的库
# 将不包含我们的项目内容，从而导致别人需要手动移动我们的库
# 需要的内容：
# 1 MathFunctionsTargets.cmake —— 以方便别人能够编译我们的库
# 2 MathFunctionsConfig.cmake —— so that the CMake find_package() command can find our project.
# 3 Config.cmake.in —— 包含 MathFunctionsTargets.cmake
# 4 MathFunctionsConfigVersion.cmake —— 包含版本信息
# 5 

# 一种解释：https://www.cnblogs.com/liuzhenbo/p/11186613.html 
# 执行export后，build文件夹中会生成一个名为 MathFunctionsTargets.cmake的文件，
# 主要内容为 MathFunctions 库所链接的其它库的绝对路径，以及 MathFunctions 库在build树中的位置。
# 这样一来，外部工程直接导入build树中的库文件就变的十分方便。

# cmake项目中一般会提供<PROJECT_NAME>Config.cmake.in文件，
# 在CMakeLists.txt中一般会将根据这个文件来生成两个在不同位置的<PROJECT_NAME>Config.cmake文件。
# 第一个是将要放在在build树中的<PROJECT_NAME>Config.cmake文件
# 第二个是将要放在install树中的<PROJECT_NAME>Config.cmake文件


# 另一种解释： https://zhuanlan.zhihu.com/p/102955723 
# 他人如果使用我们编写的函数库，安装完成后，希望可以通过find_package方法进行引用，这时我们需要怎么做呢。
# 首先我们需要生成一个MyMathConfigVersion.cmake的文件来声明版本信息
# 第二步我们将前面EXPORT MyMathTargets的信息写入到MyLibTargets.cmake文件中, 
# 该文件存放目录为${CMAKE_INSTALL_PREFIX}/lib/cmake/MyMath
# 最后我们在源代码目录新建一个MyMathConfig.cmake.in文件,用于获取配置过程中的变量，并寻找项目依赖包。
# 如果不一来外部项目的话，可以直接include MyMathTargets.cmake文件
# 最后在CMakeLists.txt文件中，配置生成MyMathTargets.cmake文件，
# 并一同安装到${CMAKE_INSTALL_PREFIX}/lib/cmake/MyMath目录中。

# 最后我们在其他项目中，就可以使用
# find_package(MyMath 1.0)
# target_linked_library(otherapp MyMath::mymath)
# 来引用我们的函数库了。

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

# control where the static and shared libraries are built so that on windows
# we don't need to tinker with the path to run the executable
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

# configure a header file to pass the version number only
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
add_subdirectory(MathFunctions)

# add the executable
add_executable(Tutorial tutorial.cxx)
target_link_libraries(Tutorial PUBLIC MathFunctions tutorial_compiler_flags)

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

# add the install targets
install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )

# enable testing
include(CTest)

# does the application run
add_test(NAME Runs COMMAND Tutorial 25)

# does the usage message work?
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")

# setup installer
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)

install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)

include(CMakePackageConfigHelpers)
# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )
# 导出一个包含版本信息的文件
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
    VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
    COMPATIBILITY AnyNewerVersion
  )
# 安装上述两个文件
  install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
    DESTINATION lib/cmake/MathFunctions
  )

# 这样我们的文件在build目录下也能用
export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)
