# 这里主要实现两个功能：
# 1 在编译过程中添加用户指令/命令
# 2 将编译过程中产生的文件包含到后续的编译过程中
add_executable(MakeTable MakeTable.cxx)
# 添加用户命令
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h # 命令的输出被重定向到文件中
  COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h # 命令
  DEPENDS MakeTable # 依赖项，得有MakeTable才能执行命令
  )



# 因为上面产生的文件需要被 mysqrt.cxx 文件使用，所以这里将
# Table.h 添加进去
add_library(MathFunctions 
            mysqrt.cxx 
            ${CMAKE_CURRENT_BINARY_DIR}/Table.h 
            )

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
# 因为库在使用过程中也要调用这个头文件，所以添加进去
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          PRIVATE   ${CMAKE_CURRENT_BINARY_DIR}
          )

# link our compiler flags interface library
target_link_libraries(MathFunctions tutorial_compiler_flags)


# install libs
set(installable_libs MathFunctions tutorial_compiler_flags)
install(TARGETS ${installable_libs} DESTINATION lib)
# install include headers
install(FILES MathFunctions.h DESTINATION include)
