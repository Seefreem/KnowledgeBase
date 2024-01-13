# 启动python主机服务

在目标机器上启动 python -m http.server 就能启动一个服务，在自己的电脑的浏览器输入目标电脑的IP和服务输出的端口号，就能访问目标服务器的文件目录，可进行下载。


# 服务器集群工具 Proxmox VE
https://blog.csdn.net/allway2/article/details/102946660 
https://zhuanlan.zhihu.com/p/63794339



# Azure
用远程桌面连接Azure上的虚拟机：
配置教程：
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/use-remote-desktop?tabs=azure-cli

注意事项：
资源组（Resource Group/ myResourceGroup）：是在 Azure 的某个虚拟机主页的信息。
myVM：是指我的虚拟机的名称，也是在虚拟机主页查看。

在配置 xrdp 的时候，要将“sudo adduser xrdp ssl-cert” 中的xrdp换成你的虚拟机的用户名，比如shiling。不然连接会失败（点击连接后，窗口直接关闭）

执行下面的这行命令的时候：
az vm open-port --resource-group myResourceGroup --name myVM --port 3389
记得替换掉其中的 myResourceGroup 和 myVM

并且记得是在Azure CLI中运行，也就是在网页上打开Azure CLI，然后执行这行命令。



远程桌面连接时的配置：
Server填写 IP:port
username: 填虚拟机的用户名，或者虚拟机名称

但是登录的时候一定是你上面 adduser 时添加的用户名。

## Application security group
这个功能在中文页面中是 Application Gateway for Containers
切换到英文页面能搜索到 Application security group。








