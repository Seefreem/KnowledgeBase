# Generating UML diagrams in python using pyreverse. Python的UML类图自动生成工具（pyreverse）
https://pylint.readthedocs.io/en/latest/pyreverse.html  
https://koomu.cn/python-uml-pyreverse/  
https://charlesreid1.com/wiki/Pyreverse   

```sh
pyreverse -o png -p MyProject your_python_file_or_module.py
# OR
pyreverse -o html -p MyProject ./
```
这里的命令参数说明如下：  
-o png 指定输出格式为 PNG 图片。你也可以选择其他格式，例如 SVG (-o svg)。  
-p MyProject 设置项目的名称，这将显示在生成的图表中。  
your_python_file_or_module.py 是你的 Python 文件或模块的路径。  
pyreverse 会生成两个文件：classes_MyProject.png 和 packages_MyProject.png。classes_MyProject.png 文件包含类图，而 packages_MyProject.png 文件展示了模块之间的关系。  


# Generating call graph in python using pycallgraph2. 创建函数调用图
Note, if you are using python3, you should install pycallgraph2 instead of pycallgraph.

Usage 1:  
```python
pycallgraph graphviz -- ./your_script.py
# 这条命令会运行 your_script.py 文件，并使用 Graphviz 生成调用图。生成的图像默认保存为 pycallgraph.png。
```

Usage 2:  
```python
)
from pycallgraph2 import PyCallGraph
from pycallgraph2.output import GraphvizOutput

with PyCallGraph(output=GraphvizOutput()):
    # your function here

```

