![](https://upload-images.jianshu.io/upload_images/3778244-65c9807c5153e98d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 概述

就是自己无聊写的一个脚本，欢迎使用，star，fork顺便关注我一波

`https://github.com/bboysoulcn/centos`

### 使用方法

这个是给最小化安装的centos使用的，在centos 7.5上测试过，当然其他的centos系统一般也没有什么问题，欢迎反馈，测试还有提交建议

首先下载脚本

`wget https://github.com/bboysoulcn/centos/blob/master/centos.sh`

之后修改执行权限

`chmod +x centos.sh`

之后执行

~~~bash
[root@bboysoul-centos ~]# ./centos.sh
**********************************
Powered by bboysoul
Email: bboysoulcn@gmail.com
Hostname: bboysoul-centos
Virtualization is not supported
Cpu model: Intel(R) Xeon(R)CPU E5620
Memory: 3790 M
Swap:  3071 M
Kernel version:  CentOS Linux release 7.5.1804 (Core)
**********************************
1) install_software    5) set_hostname	     9) install_ohmyzsh
2) install_python      6) close_selinux	    10) add_user
3) set_static_ip       7) install_docker    11) exit
4) close_firewalld     8) change_swap	    12) help:
#?
~~~

目前有下面这些小功能

- 安装一些初始化的软件
- 安装python
- 设置静态ip
- 关闭firewalld
- 设置主机名
- 关闭selinux
- 安装docker
- 改变swap大小
- 安装oh-my-zsh
- 添加用户

### 欢迎反馈bug

### 邮箱

> bboysoulcn@gmail.com

### 如果有好的建议和意见也可以提

欢迎关注Bboysoul的博客[www.bboysoul.com](http://www.bboysoul.com/)

Have Fun
