main()
{
    print_systeminfo
    centos_funcs="help install_software install_python set_static_ip close_firewalld 
                set_hostname close_selinux install_docker change_swap install_ohmyzsh add_user exit"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        0) help
        ;;
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
        8) change_swap
        ;;
        9) install_ohmyzsh
        ;;
        10) add_user
        ;;
        11) exit
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}