add_library(MathFunctions mysqrt.cxx)

    # state that anybody linking to us needs to include the current source dir
    # to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )

    # link our compiler flags interface library
target_link_libraries(MathFunctions tutorial_compiler_flags)

    # TODO 1: Create a variable called installable_libs that is a list of all
    # libraries we want to install (e.g. MathFunctions and tutorial_compiler_flags)
    # Then install the installable libraries to the lib folder.
    # Hint: Use the TARGETS and DESTINATION parameters
set(installable_libs MathFunctions tutorial_compiler_flags)
install(TARGETS ${installable_libs} DESTINATION lib)
    # TODO 2: Install the library headers to the include folder.
    # Hint: Use the FILES and DESTINATION parameters
install(FILES MathFunctions.h DESTINATION include)
    # 在 ubuntu 中，install 就是copy。
    # 需要注意的是，DESTINATION 后面并不需要加前缀，前缀默认为 /usr/local/
    # The CMake variable CMAKE_INSTALL_PREFIX is used to determine the root 
    # of where the files will be installed. If using the cmake --install command, 
    # the installation prefix can be overridden via the --prefix argument. For example:
    # cmake --install . --prefix "/home/myuser/installdir"

    # For multi-configuration tools, don't forget to use the 
    # --config argument to specify the configuration.
    # cmake --install . --config Release
    
    # If using an IDE, simply build the INSTALL target. 
    # You can build the same install target from the command line like the following:
    # cmake --build . --target install --config Debug