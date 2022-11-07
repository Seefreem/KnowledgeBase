add_library(MathFunctions mysqrt.cxx)

# TODO 1: State that anybody linking to MathFunctions needs to include the
# current source directory, while MathFunctions itself doesn't.
# Hint: Use target_include_directories with the INTERFACE keyword
target_include_directories(
    MathFunctions
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
# CMAKE_CURRENT_SOURCE_DIR is the path to the source directory currently being processed.
# 这样作的好处是，引用这个库的时候不必再显式地包含头文件目录，而只用包含库就好了。
# 当有多个编译模块需要使用这个库的时候就显得比较有用了。
# 这种处理叫做 usage requirements，还有其他的特性，可以去看看


