# vscode 提示找不到头文件：
    https://blog.csdn.net/qq_33475105/article/details/115234121#:~:text=VScode%E4%B8%AD%E6%B7%BB%E5%8A%A0%E5%A4%B4%E6%96%87%E4%BB%B6%E8%B7%AF%E5%BE%84%E6%89%93%E5%BC%80vscode%E7%94%A8Ctrl,%E6%96%87%E4%BB%B6%E7%9A%84%E8%B7%AF%E5%BE%84%E5%8D%B3%E5%8F%AF%E3%80%82
    1）在vscode中按Ctrl+Shift+P 输入configuration，选择C/C++：Edit Configuration(JSON)；
    2）编辑打开的c_cpp_properties.json文件，在configurations里的includePath中添加你需要引入的头文件的路径，保存即可。

    