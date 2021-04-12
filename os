#!/bin/bash

for var in "$@"

do
    if [ "$var" == "manage server" ]
    then
        figlet -f standard OpenStack
        echo "1. Create Server"
        echo "2. List Server"
        echo "3. Delete Server"
        echo ""
        read "Input : " s1
        case $s1 in
            1)
            echo "Server Create"
            echo "1. Single Server"
            echo "2. Many Server"
            echo "" 
            read "Input : " ss1
            case $ss1 in
                1)
                    echo "Server Has Been Create Single"
                ;;
                2)
                    echo "Server Has Been Create Many"
                ;;
            esac
            ;;
            2)
                echo "List Server"
            ;;
            3)
                echo "Delete Server"
            ;;
        esac
    fi
done