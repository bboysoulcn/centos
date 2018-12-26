#!/bin/bash


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