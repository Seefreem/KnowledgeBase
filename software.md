# 参数文件
什么数据可以放到参数文件中？
那些影响程序行为的常数就可以放在参数文件中。
通常都是那些我们想要调节的数据，但是并不想每次调节都重新编译。
通常是那些我们想要在程序运行时，根据用户的设置动态调整的参数。
通常是那些用于增加程序迁移能力的参数，比如同种类型，不同型号的设备参数。

参数文件按照什么方式放到不同的文件中？
需要放在不同的文件中，就说明参数属于不同的模块、设备、场景等等。
那么区分的标准可以是：参数功能、设备型号、运行环境、版本等。


# 复位
给程序设置一个复位功能是一个省时省力的好办法。因为在出现问题的时候可以采用复位操作，而不是重启操作。
因为重启往往都会需要更多时间，甚至可能还需要重新配置一遍相关参数。这就费力又麻烦。


# 测试可读性
在和测试的合作过程中往往会遇到一个困境，那就是测试一旦发现有任何一点点的和需求说明书不一样的情况，或者看起来不正常的情况，
就会认为可能是出问题了，就会让开发去分析日志。但是分析日志往往需要很多时间。并且很多情况下往往不是程序出问题了，而是环境
不符合设定。或者，并没有什么新的问题，只是老问题在新的场景下被触发了。因此开发会花很多时间去分析问题，然后得出一个早就知道的结论。

那么能不能给测试一些信息或者工具，让他们自己就能分析出是场景的问题，以及是已经遇到过的问题呢？

其实一个核心的问题是，测试并不知道机器为什么没有按照预期运行。那么如果能告诉测试，机器这样运行的原因，那儿测试至少就能分辨出
这个异常的原因是环境还是机器本身了。

需求定义为：
1 让测试能够自己诊断重复性的bug
2 让测试能够分辨是被测试的程序的问题还是其他问题（包括操作错误、环境因素等等）
3 让测试在遇到新的问题时，能够知道问题发生的原因，即使他可能不知道这个原因的具体含义，以及这个原因为什么导致了这个异常。


# 常见问题
1 重复定义
可能的原因：
    a 头文件没有写编译预处理指令
    b 头文件中包含了函数的实现，而不仅仅是函数的声明

2 未定义函数/类等：
可能的原因：
    a 真的没定义
    b 标识符名称写错了
    c 头文件循环引用了





