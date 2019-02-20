#!/bin/bash


change_passwd()
{
    read -p "Please enter the username you want to change your password for: " username
    passwd $username
    echo "Password reset complete"
}

# 如果用户存在那么就不创建密码
add_user()
{
    echo  "starting add user ..."
    read -p "Username:" username
    cat /etc/passwd |awk -F ":" '{ print $1 }' |grep -w $username >> /dev/null
    if [ $? == 0 ];
    then
        echo "User already exists"
    elif [ $? == 1 ];
    then
        read -p "Password:" password
        useradd $username
        echo $password |passwd --stdin $username
        echo "user created !!!"
    else
        echo "Black hole"
    fi
}

help()
{
    echo "1) help"
    echo "2) add_user"
    echo "3) change_passwd:"
}

main()
{
    centos_funcs="help add_user change_passwd"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        1) help
        ;;
        2) add_user
        ;;
        3) change_passwd
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}

main