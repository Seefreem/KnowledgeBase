    # 这个文件是配置测试结果展示面板的
    # The project name
set(CTEST_PROJECT_NAME "CMakeTutorial")
    # The project "Nightly" start time
# set(CTEST_NIGHTLY_START_TIME "00:00:00 EST")
    # CTest支持三种不同的提交模式：
    # 实验性构建: 不写 CTEST_NIGHTLY_START_TIME； 运行命令：ctest --dashboard Experimental
    # 夜间构建：要写 CTEST_NIGHTLY_START_TIME； 运行命令：ctest [-VV] -D Experimental
    # 持续构建

    # The URL of the CDash instance where the submission's generated documents will be sent
set(CTEST_DROP_METHOD "https")
set(CTEST_DROP_SITE "my.cdash.org")
set(CTEST_DROP_LOCATION "/submit.php?project=CMakeTutorial")
set(CTEST_DROP_SITE_CDASH TRUE)
    # 上述代码结合起来得到的URL是：https://my.cdash.org/submit.php?project=CMakeTutorial
    # 这里遇到一个问题，当URL 以 http开头时，上传失败，以https 开头时，上传成功

    # 运行方式：
    # hange directory to the binary tree, and then run:
    # ctest [-VV] -D Experimental

    # Remember, for multi-config generators (e.g. Visual Studio), 
    # the configuration type must be specified:
    # ctest [-VV] -C Debug -D Experimental
    
    # Or, from an IDE, build the Experimental target.
    # The ctest executable will build and test the project and submit 
    # the results to Kitware's public dashboard: https://my.cdash.org/index.php?project=CMakeTutorial.

    # 运行后，命令行会输出下面的信息：
    # Site: seelur-T58-D —— 据此在网站上找到自己的测试结果
    # Build name: Linux-c++
    # Create new tag: 20221107-0342 - Experimental
    # Configure project
    # Each . represents 1024 bytes of output
    #     . Size of output: 0K

