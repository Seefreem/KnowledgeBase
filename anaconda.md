# Anaconda 
Anaconda 是一个虚拟环境。管理的是python相关的程序包。注意仅仅是python相关的。Anaconda解决的是多版本python包管理的问题。

Docker是容器技术，类似于虚拟机，只不过虚拟的是application和application的运行环境。docker 解决的是app跨平台运行的问题。
比如开发者在自己的电脑上开发好APP，并且将整个开发环境打包成docker的一个镜像，那么其他人就可以拉取这个镜像，然后在他们的电脑上运行，而不用安装任何依赖。（听起来很完美，但是没用过）




# Anaconda基本命令

## conda自身相关

查看当前conda工具版本号

conda --version


查看包括版本的更多信息

conda info

更新conda至最新版本

conda update conda

查看conda帮助信息

conda -h


## 环境管理相关

查看conda环境管理命令帮助信息
conda create --help


创建出来的虚拟环境所在的位置为conda路径下的env/文件下,,默认创建和当前python版本一致的环境.
conda create --name envname


创建新环境时指定python版本为3.6，环境名称为python36
conda create --name python36 python=3.6


切换到环境名为python36的环境（默认是base环境），切换后可通过python -V查看是否切换成功
conda activate python36


返回前一个python环境
conda deactivate
显示已创建的环境，会列出所有的环境名和对应路径

conda info -e


删除虚拟环境
conda remove --name envname --all

克隆一个环境
clone_env 代指克隆得到的新环境的名称
envname 代指被克隆的环境的名称
conda create --name clone_env --clone envname

#查看conda环境信息
conda info --envs


查看有哪些环境
conda env list

修改环境中的python版本


## 包管理

指定python版本,以及多个包

conda create -n envname python=3.4 scipy=0.15.0 astroib numpy


查看当前环境安装的包

conda list   ##获取当前环境中已安装的包 (和pip list不一样) 
conda list -n python36   ##获取指定环境中已安装的包




查看包信息
conda list --explicit

导出包信息到当前目录, spec-file.txt为导出文件名称,可以自行修改名称
conda list --explicit > spec-file.txt

使用包信息文件建立和之前相同的环境
conda create --name newenv --file spec-file.txt

使用包信息文件向一个已经存在的环境中安装指定包
conda install --name newenv --file spec-file.txt


查找包

#模糊查找，即模糊匹配，只要含py字符串的包名就能匹配到
conda search py   

##查找包，--full-name表示精确查找，即完全匹配名为python的包
conda search --full-name python


安装更新删除包

##在当前环境中安装包
conda install scrapy  

##在指定环境中安装包
conda install -n python36 scrapy

##在当前环境中更新包  
conda update scrapy   

##在指定环境中更新包
conda update -n python36 scrapy  

##更新当前环境所有包
conda update --all   

##在当前环境中删除包
conda remove scrapy   

##在指定环境中删除包
conda remove -n python2 scrapy


## Python管理

查找可以安装的python

查找所有名称包含python的包
conda search python

查找全名为python的包
conda search --full-name python


安装不同版本的Python

#在不影响当前版本的情况下,新建环境并安装不同版本的python
#新建一个Python版本为3.6 名称为 py36 的环境

conda create -n py36 python=3.6 anaconda

#注:将py36替换为您要创建的环境的名称。 anaconda是元数据包，带这个会把base的基础包一起安装，不带的话新环境只包含python3.6相关的包。 python = 3.6是您要在此新环境中安装的软件包和版本。 这可以是任何包，例如numpy = 1.7，或多个包。
#然后激活想要使用的环境即可
conda activate py36
## 更新Python
普通的更新python
conda update python

将python更新到另外一个版本/安装指定版本的python
conda install python=3.6


## 分享环境

如果你想把你当前的环境配置与别人分享，这样ta可以快速建立一个与你一模一样的环境（同一个版本的python及各种包）来共同开发/进行新的实验。一个分享环境的快速方法就是给ta一个你的环境的.yml文件。



首先通过activate target_env要分享的环境target_env，然后输入下面的命令会在当前工作目录下生成一个environment.yml文件

conda env export > environment.yml


小伙伴拿到environment.yml文件后，将该文件放在工作目录下，可以通过以下命令从该文件创建环境

conda env create -f environment.yml
