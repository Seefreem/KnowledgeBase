import matplotlib.animation as animation
import matplotlib.pyplot as plt
import numpy as np
'''
用Python将图片绘制成视频
将plot绘图结果制作成视频
需要用到 ffmpeg 工具，安装教程：
https://phoenixnap.com/kb/install-ffmpeg-ubuntu
'''
## 提取参考路径
reference_path_file_name = 'road_points_new.txt'
reference_path_file = open(reference_path_file_name)
reference_path = [[], []]
counter = 1
downsample_rate = 5
for line in reference_path_file:
    # print(line)
    elements = line.split("	") # 注意这里是tab，而不是blackspace
    # print(len(elements))
    if counter % downsample_rate == 0:
        try:
            x = float(elements[0])
            y = float(elements[1])
        except ValueError:
            continue
        reference_path[0].append(x)
        reference_path[1].append(y)
    counter += 1

reference_path_file.close()

print("length of reference_path is ", len(reference_path[0]), len(reference_path[1]))

## 绘制车辆轨迹
log_name = "decision_log.txt"
source_file = open("./log/" + log_name)
positions = []
title = []
sample_rate = 2
counter = 0
for line in source_file:
    if "车辆实际速度" in line:
        counter += 1
        if counter % sample_rate == 0:
            # print(line)
            pass
    if "车辆坐标" in line:
        counter += 1
        if counter % sample_rate == 0:
            numbers = line.split(" ")[6:8]
            
            print(numbers)
            try:
                x = float(numbers[0].split(",")[0])
                y = float(numbers[1].split(",")[0])
                # if x < 0:
                #     # print(numbers)
                #     # print(x)
                #     # print(y)
                print([x, y])
                positions.append([x, y])
                title.append(line.split(" ")[0])
            except ValueError:
                continue

source_file.close()
print ("len of positions is ", len(positions))
ims = []
fig = plt.figure()
temp_x = []
temp_y = []
for i in range(1,len(positions)):
    temp_x.append(positions[i][0])
    temp_y.append(positions[i][1])
    im = plt.plot(temp_x, temp_y,'m',reference_path[0], reference_path[1],'g')
    # plt.legend()
    # 绘制散点图时，比较特殊需要调用findobj：im = plt.scatter(1,1).findobj()
    # im.title(title[i])
    ims.append(im)
ani = animation.ArtistAnimation(fig, ims, interval=500, repeat_delay=1000)
# ani.save("test.gif", writer='pillow')

Writer = animation.writers['ffmpeg']  # 需安装ffmpeg
writer = Writer(fps=15, metadata=dict(artist='Me'), bitrate=1800)
ani.save("movie.mp4",writer=writer)

