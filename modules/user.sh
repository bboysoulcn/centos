#!/bin/bash
change_passwd()
{


}

add_user()
{
    echo  "starting add user ..."
    read -p "Username:" username
    read -p "Password:" password
    useradd $username
    echo $password |passwd --stdin $username
    echo "user created !!!"
}