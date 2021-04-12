#!/bin/bash

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

for var in "$@"
do
    if [ -z "$var" ]
    then
        helpFunction


# Manage Server Openstack
    elif [ "$var" == "manage-server" ]
    then
        ls -la ~/
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
                clear
                figlet -f standard openstack
                echo "List Server"
                openstack server list
            ;;
            3)
                clear
                figlet -f standard openstack
                echo "List Server"
                openstack server list
                echo ""
                read -p "Select Server (Name/ID) : " slt
                openstack server delete $slt
            ;;
        esac

# Manage Project Openstack
    elif [ "$var" == "manage-project" ]
    then
        ls -la ~/
        read -p "Keystone : " ks
        source ~/$ks
        figlet -f standard OpenStack
        echo "1. Create Project"
        echo "2. List Project"
        echo "3. Delete Project"
        echo ""
        read -p "Input : " s1
        case $s1 in
            1)
            echo "Project Create"
            echo ""
            echo "1. Single Project"
            echo "2. Many Project"
            echo "" 
            read -p "Input : " ss1
            case $ss1 in
                1)
                    clear
                    figlet -f standard openstack
                    echo "Project Create"
                    echo ""
                    openstack project list
                    read -p "Name Project : " np
                    read -p "Description : " desc
                    openstack project create --description "$desc" $np
                ;;
                2)
                    clear
                    figlet -f standard openstack
                    echo "Project Create"
                    echo ""
                    read -p "Name Project : " np
                    read -p "Description : " desc
                    read -p "Loop : " a

                    for ((i=1;i<=$a;i++)); 
                    do
                        openstack project create --description "$desc" $np$i
                    done
                ;;
            esac
            ;;
            2)
                clear
                figlet -f standard openstack
                echo "List Project"
                openstack project list
            ;;
            3)
                clear
                figlet -f standard openstack
                echo "List Project"
                openstack project list
                echo ""
                read -p "Select Project (Name) : " slt
                openstack project delete $slt
            ;;
        esac
    fi
done
