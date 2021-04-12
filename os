#!/bin/bash


for var in "$@"
do
    helpFunction()
    {
        lst=("server" "image" "flavor" "network")
        echo "Usage: $0 "
        echo -e "\tmanage-${lst[0]} Manage ${lst[0]} OpenStack"
        echo -e "\tmanage-${lst[1]} Manage ${lst[1]} OpenStack"
        echo -e "\tmanage-${lst[2]} Manage ${lst[2]} OpenStack"
        echo -e "\tmanage-${lst[3]} Manage ${lst[3]} OpenStack"
        exit 1 # Exit script after printing help
    }
    
    if [ -z "$var" ]
    then
        helpFunction

    elif [ "$var" == "manage-server" ]
    then
        read -p "Keystone : " ks
        source ~/$ks
        figlet -f standard OpenStack
        echo "1. Create Server"
        echo "2. List Server"
        echo "3. Delete Server"
        echo ""
        read -p "Input : " s1
        case $s1 in
            1)
            echo "Server Create"
            echo "1. Single Server"
            echo "2. Many Server"
            echo "" 
            read -p "Input : " ss1
            case $ss1 in
                1)
                    clear
                    figlet -f standard openstack
                    echo "Server Create"
                    echo ""
                    read -p "Name Server : " ns
                    openstack image list
                    read -p "Image : " im
                    openstack flavor list
                    read -p "Flavor : " fl
                    openstack network list
                    read -p "Network : " nw
                    openstack server create --image $im --flavor $fl --nic net-id=$nw --wait $ns
                ;;
                2)
                    clear
                    figlet -f standard openstack
                    echo "Server Create"
                    echo ""
                    read -p "Name Server : " ns
                    read -p "Image : " im
                    read -p "Flavor : " fl
                    read -p "Network : " nw
                    read -p "Loop : " a

                    for ((i=1;i<=$a;i++)); 
                    do 
                       openstack server create --image $im --flavor $fl --nic net-id=$nw --wait $ns$i
                    done
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
