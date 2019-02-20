#!/bin/bash

Install_Apache()
{
    useradd apache
    yum install -y apr-devel apr-util-devel pcre-devel
	wget http://mirrors.ustc.edu.cn/apache/httpd/httpd-2.4.37.tar.gz
    tar -zxvf httpd-2.4.37.tar.gz
    make 
    make install
    chown -Rf apache:apache /usr/local/apache
}

main()
{

}
