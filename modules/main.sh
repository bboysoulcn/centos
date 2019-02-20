#!/bin/bash

main()
{
    bash system_info.sh
    centos_funcs="help network software system user"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        1) bash modules/help.sh
        ;;
        2) bash modules/network.sh
        ;;
        3) bash modules/software.sh
        ;;
        4) bash modules/user.sh
        ;;
        5) bash modules/help.sh
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}

main
