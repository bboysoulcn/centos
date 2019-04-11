#!/bin/bash
# CentOS Linux release 7.5.1804 系统 初始化脚本
# powered by bboysoul
# todo
# 检查ip是不是有效
# 重启系统？
# 测试软件是不是安装完成了
# 设置swap的时候GM大写
# 修改ssh端口
# 定时重启
# 晚上定时kill ssh
# ssh 端口 只允许特定ip
# 显示系统信息
# 设置dns
# 修改docker镜像地址


add_user()
{
    echo  "starting add user ..."
    read -p "Username:" username
    read -p "Password:" password
    useradd $username
    echo $password |passwd --stdin $username
    echo "user created !!!"
}

install_software()
{
    echo "starting install software ..."
    yum install epel-release -y
    yum update -y
    yum install git wget screen  nmap vim htop iftop iotop gcc gcc-c++ net-tools unzip nfs-utils psmisc zip rsync telnet -y
    echo "software installed !!!"
}

install_python()
{
    echo "starting install python ..."
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    echo "export PATH=\"/root/.pyenv/bin:\$PATH\"">>/etc/profile
    echo "eval \"\$(pyenv init -)\"">>/etc/profile
    echo "eval \"\$(pyenv virtualenv-init -)\"">>/etc/profile
    source /etc/profile
    echo "python installed !!!"
}

set_static_ip()
{
    # 检查/etc/sysconfig/network-scripts/ifcfg-enp0s3存不存在
    # 检查如果有静态ip那么提示静态ip已经设置完成
    echo "starting setting static ip ..."
    filename="/etc/sysconfig/network-scripts/ifcfg-enp0s3"
    if [ -f $filename ]
    then
        read -p "Please enter the static ip you want to set: " ip
        read -p "Please enter the gateway you want to set: " gateway
        read -p "Please enter the netmask ip you want to set: " netmask
        read -p "Please enter the dns ip you want to set: " dns1
        echo "文件存在"
        echo -e "IPADDR=\"$ip\"">>$filename
        echo -e "GATEWAY=\"$gateway\"">>$filename
        echo -e "NETMASK=\"$netmask\"">>$filename
        echo -e "DNS1=\"$dns1\"">>$filename
        sed -i 's/BOOTPROTO="dhcp"/BOOTPROTO="static"/g' $filename
    else
        read -p  "thereis no ifcfg-enp0s3 file so please input your filename( in /etc/sysconfig/network-scripts/ like ifcfg-en*):" filename
        read -p "Please enter the static ip you want to set: " ip
        read -p "Please enter the gateway you want to set: " gateway
        read -p "Please enter the netmask ip you want to set: " netmask
        read -p "Please enter the dns ip you want to set: " dns1
        echo -e "IPADDR=\"$ip\"">>$filename
        echo -e "GATEWAY=\"$gateway\"">>$filename
        echo -e "NETMASK=\"$netmask\"">>$filename
        echo -e "DNS1=\"$dns1\"">>$filename
        sed -i 's/BOOTPROTO="dhcp"/BOOTPROTO="static"/g' $filename
    fi
    echo "static ip set !!!"
}

close_firewalld()
{
    echo "starting stop firewalld ..."
    systemctl stop firewalld
    systemctl disable firewalld
    echo "firewalld stoped !!!"
}

set_hostname()
{
    echo "start set your hostname ..."
    read -p "please input your hostname: " hostname
    hostnamectl set-hostname $hostname
    echo "your hostname is set to" $hostname
}

close_selinux()
{
    echo "starting close selinux ..."
    setenforce 0
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    echo "selinux closed !!!"
}

install_docker()
{
    echo "installing docker ..."
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
    echo "docker installed !!!!!!!!!!!"
    systemctl start docker && systemctl enable docker
    echo "installing docker-compose ......"
    wget https://github.com/docker/compose/releases/download/1.23.2/docker-compose-Linux-x86_64
    mv docker-compose-Linux-x86_64 /usr/bin/docker-compose
    chmod +x /usr/bin/docker-compose
    echo "docker-compose installed !!!"
}

change_docker_mirror()
{
    cat >  /etc/docker/daemon.json <<EOF
{
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF
    systemctl restart docker
}

change_swap()
{
    echo "starting change swap ..."
    read -p "please input your swapfile size:" size
    dd if=/dev/zero of=/usr/local/swapfile  bs=$size count=1
    mkswap /usr/local/swapfile
    swapon /usr/local/swapfile
    echo "/usr/local/swapfile     swap                    swap    defaults        0 0" >> /etc/fstab
    echo "swap changed !!!"
}

#kernel_optimization()

install_ohmyzsh()
{
    echo "starting install oh-my-zsh ..."
    yum install zsh -y
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "oh-my-zsh installed !!!"
}

print_systeminfo()
{
    echo "**********************************"
    echo "Powered by bboysoul"
    echo "Email: bboysoulcn@gmail.com"
    echo "Hostname:" `hostname`
    # virtualization
    cat /proc/cpuinfo |grep vmx >> /dev/null
    if [ $? == 0 ]
    then
        echo "Supporting virtualization"
    else
        echo "Virtualization is not supported"
    fi
    echo "Cpu model:" `cat /proc/cpuinfo |grep "model name" | awk '{ print $4" "$5""$6" "$7 ; exit }'`
    echo "Memory:" `free -m |grep Mem | awk '{ print $2 }'` "M"
    echo "Swap: " `free -m |grep Swap | awk '{ print $2 }'` "M"
    echo "Kernel version: " `cat /etc/redhat-release`
    echo "**********************************"
}

help()
{
    echo "1) install_software	   6) close_selinux	    11) add_user"
    echo "2) install_python	   7) install_docker	    12) exit"
    echo "3) set_static_ip	   8) change_docker_mirror  13) help:"
    echo "4) close_firewalld	   9) change_swap"
    echo "5) set_hostname		  10) install_ohmyzsh"
}

main()
{
    print_systeminfo
    centos_funcs="install_software install_python set_static_ip close_firewalld 
                set_hostname close_selinux install_docker change_docker_mirror change_swap install_ohmyzsh add_user exit help"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        1) install_software
        ;;
        2) install_python
        ;;
        3) set_static_ip
        ;;
        4) close_firewalld
        ;;
        5) set_hostname
        ;;
        6) close_selinux
        ;;
        7) install_docker
        ;;
        8) change_docker_mirror
        ;;
        9) change_swap
        ;;
        10) install_ohmyzsh
        ;;
        11) add_user
        ;;
        12) exit
        ;;
        13) help
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}

main

