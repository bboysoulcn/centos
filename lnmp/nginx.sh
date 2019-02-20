#!/bin/bash
# 分为三个版本 最新版本 稳定版本 老版本
# 判断操作系统 安装依赖



Install_Openssl()
{
    wget https://www.openssl.org/source/openssl-1.1.1a.tar.gz
    ./configure --prefix=/usr/local/nginx --with-openssl=../../openssl/openssl-1.0.2q/

}

choose_nginx()
{
    yum install zlib-devel

    while : 
    do
        read -p "please choose the nginx version: " version
        case $version in
            1) wget http://nginx.org/download/nginx-1.15.8.tar.gz
               echo "nginx-v1.15 is downloaded"
               tar -zxvf nginx-1.15.8.tar.gz
               cd nginx-1.15.8
               ./configure --prefix=/home/lnmp/nginx/
               return 1
               break
            ;;
            2) wget http://nginx.org/download/nginx-1.14.2.tar.gz
               echo "nginx-v1.14 is downloaded"
               tar -zxvf nginx-1.14.2.tar.gz
               cd nginx-1.14.2
               ./configure --prefix=/home/lnmp/nginx/
               return 2
               break
            ;;
            3) wget http://nginx.org/download/nginx-1.12.2.tar.gz
               echo "nginx-v1.12 is downloaded"
               tar -zxvf nginx-1.12.2.tar.gz
               cd nginx-1.12.2
               ./configure --prefix=/home/lnmp/nginx/
               return 3
               break
            ;;
            *) echo "please choose a right version"
            ;;
        esac
    done
}

compile_nginx()
{
    choose_nginx
    
}

main()
{
    compile_nginx
}

main
