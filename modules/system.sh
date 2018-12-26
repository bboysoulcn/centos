#!/bin/bash


#kernel_optimization()

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