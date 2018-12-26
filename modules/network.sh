#!/bin/bash
IPADDR="192.168.1.100"
GATEWAY="192.168.1.1"
NETMASK="255.255.255.0"
UUID=nmcli con show | awk '{ print $2 }' |grep -v UUID
DEVICE=nmcli con show | awk '{ print $4 }' |grep -v DEVICE
NAME=nmcli con show | awk '{ print $1 }' |grep -v NAME

DNS2="114.114.114.114"
DNS1="192.168.1.100"

set_static_ip()
{
    # 检查/etc/sysconfig/network-scripts/ifcfg-enp0s3存不存在
    # 检查如果有静态ip那么提示静态ip已经设置完成
    echo "starting setting static ip ..."
    filename="/etc/sysconfig/network-scripts/ifcfg-enp0s3"
    read -p "Please enter the static ip you want to set: " ip
    read -p "Please enter the gateway you want to set: " gateway
    read -p "Please enter the netmask ip you want to set: " netmask
    read -p "Please enter the dns ip you want to set: " dns1
    if [ -f $filename ]
    then
        echo "文件存在"
        mv $filename $filename.bak
        cat >> $filename <<EOF
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
ONBOOT="yes"
EOF
        echo -e "IPADDR=\"$ip\"">>$filename
        echo -e "GATEWAY=\"$gateway\"">>$filename
        echo -e "NETMASK=\"$netmask\"">>$filename
        echo -e "DNS1=\"$dns1\"">>$filename
    else
        read -p  "thereis no ifcfg-enp0s3 file so please input your filename( in /etc/sysconfig/network-scripts/ like ifcfg-en*):" filename
        mv $filename $filename.bak
        cat >> $filename <<EOF
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
ONBOOT="yes"
EOF
        echo -e "IPADDR=\"$ip\"">>$filename
        echo -e "GATEWAY=\"$gateway\"">>$filename
        echo -e "NETMASK=\"$netmask\"">>$filename
        echo -e "DNS1=\"$dns1\"">>$filename
    fi
    echo "static ip set !!!"
    read -p  "Do you want to restart network(yes/no)? " answer
    if [ $answer == "yes" ];
    then
        echo "if you are using ssh the connection may be closed"
        systemctl restart network
    elif [ $answer == "no" ];
    then
        echo "the network will not be restart"
        echo "if you want to change the ip please restart the network by yourself"
    else
        echo "please input (yes/no)"

}