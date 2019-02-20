#!/bin/bash

main()
{
    bash system_info.sh
    centos_funcs="help network software system user"
    select centos_func in $centos_funcs:
    do 
        case $REPLY in
        1) echo "help"
        ;;
        2) echo "network"
        ;;
        3) echo "software"
        ;;
        4) echo "system"
        ;;
        5) echo "user"
        ;;
        *) echo "please select a true num"
        ;;
        esac
    done
}

main