
# 什么是easylogging？
easylogging++ 是一个开源的日志工具

# 使用方法

==1 作为库
1 首先在写CMakeLists.txt文件将日志代码编译成库文件；
2 在项目的某个目录/根目录中的CMakeLists.txt 添加：
    easylogging所在的子目录：(编译)
    add_subdirectory(logger)
    并包含头文件：(编程)
    include_directories("./logger/src")
3 在子目录的CMakeLists.txt文件中链接easylogging库：
    target_link_libraries(${PROJECT_NAME}
                        easylogging
                        )
    target_include_directories(${PROJECT_NAME} PUBLIC
                            "${PROJECT_BINARY_DIR}"
                            "${PROJECT_SOURCE_DIR}/logger"
                            )

关于easylogging的代码怎么编写，就参考下面的“2 作为源文件”。

==2 作为源文件
直接将easylogging的头文件和源文件放在项目中就行。

代码实现：
1 如果需要多线程安全，则在头文件 easylogging++.h 中 定义：#define ELPP_THREAD_SAFE    // enable multi-thread-safty
2 在主函数所在的文件中，在最后一个include语句之后：执行宏： INITIALIZE_EASYLOGGINGPP
3 在主函数体中，开头部分运行：
```cpp
    SETUP_DEFAULT_EASYLOGGINGPP("src/nodes/n_v_decision/log_config/decision.conf");
```
    宏的定义如下：
 ```cpp
    // 这个可以作为公用的预定义宏
    #ifndef SETUP_DEFAULT_EASYLOGGINGPP
    #define SETUP_DEFAULT_EASYLOGGINGPP(config_file, RolloutHandler) {  \
    el::Loggers::addFlag(el::LoggingFlag::StrictLogFileSizeCheck);   \
    el::Configurations conf(config_file);                            \
    el::Loggers::reconfigureLogger("default", conf);                 \
    el::Helpers::installPreRollOutCallback(RolloutHandler);          \
    } 
    #endif 
 ``` 
    这里加载了一个配置文件src/nodes/n_v_decision/log_config/decision.conf。
    文件的路径是从运行程序的目录开始的。
4 配置文件：
```conf
    * GLOBAL:  
        ENABLED                 =   true  
        TO_FILE                 =   true  
        TO_STANDARD_OUTPUT      =   true   
        FORMAT                  =   "[%datetime|%fbase:%line] %msg" # 输出格式
        FILENAME                =   "./log/decision_%datetime{%Y%M%d}.log" # 默认日志文件名
        MILLISECONDS_WIDTH      =   3  
        PERFORMANCE_TRACKING    =   false  
        MAX_LOG_FILE_SIZE       =   104857600 # unit: bytes; 100M 
        LOG_FLUSH_THRESHOLD     =   0  
        
    # * TRACE:  
    #     FILENAME                =   "./log/decision_trace_%datetime{%Y%M%d}.log" # 输出文件  
        
    # * DEBUG:  
    #     FILENAME                =   "./log/decision_debug_%datetime{%Y%M%d}.log"  
        
    # * FATAL:  
    #     ENABLED                 =   false  
        
    * ERROR:  
        FILENAME                =   "./log/decision_error_%datetime{%Y%M%d}.log"  
        
    * WARNING:  
        FILENAME                =   "./log/decision_warning_%datetime{%Y%M%d}.log"  
        
    * INFO:  
        FILENAME                =   "./log/decision_info_%datetime{%Y%M%d}.log"  
        
    # * VERBOSE:  
    #     ENABLED                 =   false  
```
## 输出格式/配置文件设置
https://www.cnblogs.com/warmlight/p/14156235.html

# easylogging 的性能分析：
easylogging的日志性能比std::cout流式传输的低，原因是easylogging内部的处理逻辑会更多，
并且每次写日志的时候都会创建日志对象以及其他的操作，兑现的创建会消耗比较多的时间。

比如简单的basic log的展开过程如下：
```cpp
    #define LOG(LEVEL) CLOG(LEVEL, ELPP_CURR_FILE_LOGGER_ID)
    
    #define CLOG(LEVEL, ...)\
    C##LEVEL(el::base::Writer, el::base::DispatchAction::NormalLog, __VA_ARGS__)
    // 在宏定义中 # 表示将宏参数变为字符串；## 表示将两个宏参数连接为一个字符串。因此C##LEVEL就表示CLEVEL，当LEVEL的值是INFO的时候
    // C##LEVEL的结果就是CINFO。
    // el::base::DispatchAction::NormalLog 是枚举，区分日志信息是记录为普通日志信息还是系统日志信息。如果是记录为系统日志信息，那么代码中的日志就会存到系统日志目录下。
    
    #define CINFO(writer, dispatchAction, ...) ELPP_WRITE_LOG(writer, el::Level::Info, dispatchAction, __VA_ARGS__)

    #define ELPP_WRITE_LOG(writer, level, dispatchAction, ...) \
    writer(level, __FILE__, __LINE__, ELPP_FUNC, dispatchAction).construct(el_getVALength(__VA_ARGS__), __VA_ARGS__)
    // 所以实际上就是创建了一个匿名的 writer 对象，然后调用 construct 函数写入文件。
```
# easylogging 的 条件输出是怎么实现的？
    就是一个简单的条件语句
    if (condition)
        statement
# easylogging 的 计数输出是怎么实现的？
计数分为以下几种类型：
    LOG_EVERY_N(n, LEVEL)
    LOG_AFTER_N(n, LEVEL)
    LOG_N_TIMES(n, LEVEL)
三种类型都采用了计数器（m_hitCounts）来记录是第几次运行到这个日志语句。
当计数器取余n为零时，就执行 LOG_EVERY_N 中的打印语句；
当计数器大于n时，就执行 LOG_AFTER_N 中的打印语句；
当计数器小于n时，就执行 LOG_N_TIMES 中的打印语句；

每一个打印语句都用逻辑判断中的短路代替了if条件语句（condition && log(...)）。

并且在easylogging中采用了一个变量（std::vector<...> m_list）来存储所有的计数日志并且用文件名+行号作为"索引"。
这里的"索引"其实就是用的std::find_if()。在条件函数比较文件名和行号，如果相等，那就找到了。

# easylogging中的printful类型的输出是怎么实现的？

# easylogging中时如何操作文件的？

## 如何创建文件？

## 如何检测文件大小？

## 如何对文件进行操作？

# 如何实现自己的简单版本的日志系统呢？

# Performance Tracking

All you need to do is use one of two macros from where you want to start tracking.

TIMED_FUNC(obj-name)
TIMED_SCOPE(obj-name, block-name)
TIMED_BLOCK(obj-name, block-name)
An example that just uses usleep
```cpp
void performHeavyTask(int iter) {
   TIMED_FUNC(timerObj);
   // Some initializations
   // Some more heavy tasks
   usleep(5000);
   while (iter-- > 0) {
       TIMED_SCOPE(timerBlkObj, "heavy-iter");
       // Perform some heavy task in each iter
       usleep(10000);
   }
}
```

# 日志滚动（rorate/rotating/保留历史日志）
因为easylogging默认只保存最近的一个日志文件。也就是当日志大小到达最大的限制时，会清空文件内容，重新写入。文件名不会变。
因此需要手动保存历史日志。
回调函数：
```cpp
// 备份日志的回调函数，这里的filename就是配置文件中的FILENAME的值
void RolloutHandler(const char* filename, std::size_t size) {
  time_t t = time(NULL);
  char time_str[64] = {0};
  // 给日志加上时间后缀 
  strftime(time_str, sizeof(time_str) - 1, "_%m_%d_%H_%M", localtime(&t)); 
  std::string str(filename);
  std::stringstream ss;
  ss << "mv " << filename << " " 
     << str.substr(0, str.length() - 4)/*去掉“.log”后缀*/ << time_str << ".log";
  std::system(ss.str().c_str());
}
```
注册回调函数：
```cpp
el::Helpers::installPreRollOutCallback(RolloutHandler);
```
通过预定义宏