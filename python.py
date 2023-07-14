

# python 画图
def is_contain_chinese(check_str):
    """
    判断字符串中是否包含中文
    :param check_str: {str} 需要检测的字符串
    :return: {bool} 包含返回True， 不包含返回False
    """
    for ch in check_str:
        if u'\u4e00' <= ch <= u'\u9fff':
            return True
    return False

def is_decimal(check_str):
    """
    判断字符串中是否包含中文
    :param check_str: {str} 需要检测的字符串
    :return: {bool} 包含返回True， 不包含返回False
    """
    for ch in check_str:
        if '0' <= ch <= '9' or ch == '.':
            pass
        else :
            return False;
    return True;
# print(type(eval("123.23asdad")) == float)  

old_version = []
f = open("decision_log.txt")
line = f.readline()
while line:
    if ("时间差" in line):
        splited_str = line.split(" ") # 111111时间差 = 0.000402451
        if ((is_decimal(splited_str[2].strip()))): 
            old_version.append(float(splited_str[2]))
            # print(float(splited_str[2]))
            # print(type(splited_str[2]))
            # print("old_version", len(old_version))
    line = f.readline()
f.close()

new_version = []
f = open("./log/decision_info_20230110.log")
line = f.readline()
print("readline")
while line:
    # print(line)
    if ("时间差" in line):
        splited_str = line.split(" ") # 111111时间差 = 0.000402451
        if ((is_decimal(splited_str[4].strip()))): 
            new_version.append(float(splited_str[4]))
            # print(float(splited_str[4]))
            # print(type(splited_str[4]))
            # print("new_version", len(new_version))
    line = f.readline()
f.close()

print(len(old_version))
print(len(new_version))

#多图绘制
#导入包numpy
import numpy as np
#导入matplotlib的pyplot模块
import matplotlib.pyplot as plt
#定义一维数组

line1 = range(0, len(old_version))
line2 = range(0, len(new_version))
diff = []
min_index = min(len(old_version), len(new_version))
for i in range(0, min_index):
    diff.append(old_version[i] - new_version[i])
line3 = range(0, min_index)

fig, ax = plt.subplots() # 创建图实例

ax.plot(line1, old_version, label='old_version') # 作y1 = x 图，并标记此线名为linear
ax.plot(line2, new_version, label='new_version') #作y2 = x^2 图，并标记此线名为quadratic
ax.plot(line3, diff, label='diff') # 作y3 = x^3 图，并标记此线名为cubic

ax.set_xlabel('x label') #设置x轴名称 x label
ax.set_ylabel('y label') #设置y轴名称 y label
ax.set_title('Simple Plot') #设置图名为Simple Plot
ax.legend() #自动检测要在图例中显示的元素，并且显示
plt.show() #图形可视化



'''
数据处理，统计学处理，曲线滤波，均值滤波，线性滤波
https://blog.csdn.net/weixin_42782150/article/details/107176500 
https://blog.csdn.net/sinat_28252525/article/details/80462437 
为什么不直接使用excel呢？点点点就完了

'''
# python求均值、中位数、众数
# 求均值和中位数均可以使用numpy库的方法：
import numpy as np
#均值
np.mean(nums)
#中位数
np.median(nums)

# 求众数方法一：
# 在numpy中没有直接的方法，但是也可以这样实现：
import numpy as np
counts = np.bincount(nums) # 返回众数


# 求众数方法二——直接利用scipy下stats模块【推荐】：
from scipy import stats
stats.mode(nums)[0][0]


# 使用Savitzky-Golay 滤波器后得到平滑图线
from scipy.signal import savgol_filter
y_smooth = scipy.signal.savgol_filter(y,53,3)  
# 亦或
y_smooth2 = savgol_filter(y, 99, 1, mode= 'nearest')
# 备注：
# y：代表曲线点坐标（x,y）中的y值数组
# window_length：窗口长度，该值需为正奇整数。例如：此处取值53
# k值：polyorder为对窗口内的数据点进行k阶多项式拟合，k的值需要小于window_length。例如：此处取值3
# mode：确定了要应用滤波器的填充信号的扩展类型。（This determines the type of extension to use for the padded signal to which the filter is applied. ）


