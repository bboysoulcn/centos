#!/bin/bash
changer_mirrors()
{

}

install_software()
{
    echo "starting install software ..."
    yum install epel-release -y
    yum update -y
    yum install git wget screen  nmap vim htop iftop iotop gcc gcc-c++ net-tools unzip nfs-utils psmisc zip rsync  -y
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
install_jdk()
{
    echo  "starting install jdk ..."
    
    
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
    read -p "Do you want to change the docker registry?(yese/no)"
    if []
}

install_ohmyzsh()
{
    echo "starting install oh-my-zsh ..."
    yum install zsh -y
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "oh-my-zsh installed !!!"
}


help()
{

}

main()
{
    centos_funcs="changer_mirrors install_software install_python install_jdk install_docker install_ohmyzsh"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        1) help
        ;;
        2) changer_mirrors
        ;;
        3) install_software
        ;;
        4) install_python
        ;;
        5) install_jdk
        ;;
        6) install_docker
        ;;
        7) install_ohmyzsh
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}

main