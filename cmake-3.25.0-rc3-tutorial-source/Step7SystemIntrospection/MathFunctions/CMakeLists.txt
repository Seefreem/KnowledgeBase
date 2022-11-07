add_library(MathFunctions mysqrt.cxx)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )

# link our compiler flags interface library
target_link_libraries(MathFunctions tutorial_compiler_flags)

# install libs
set(installable_libs MathFunctions tutorial_compiler_flags)
install(TARGETS ${installable_libs} DESTINATION lib)
# install include headers
install(FILES MathFunctions.h DESTINATION include)

# 检测是否编译平台是否包含某个函数
# 检测是否编译平台是否能够运行某段C++代码
# does this system provide the log and exp functions?
include(CheckCXXSourceCompiles)
# check_cxx_source_compiles( "C++代码段" 返回值变量)
check_cxx_source_compiles("
  #include <cmath>
  int main() {
    std::log(1.0);
    return 0;
  }
" HAVE_LOG)
check_cxx_source_compiles("
  #include <cmath>
  int main() {
    std::exp(1.0);
    return 0;
  }
" HAVE_EXP)

# 如果编译平台包含上述两个函数
# 如果编译平台能够运行上述C++代码
# 将 HAVE_LOG AND HAVE_EXP 设置为 private
# 控制访问范围/作用域
if(HAVE_LOG AND HAVE_EXP)
  target_compile_definitions(MathFunctions
                             PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()
# 注意：这里定义了两个宏 HAVE_LOG AND HAVE_EXP，在 MathFunctions 中可以访问，
# 也就是在源文件中可以访问

