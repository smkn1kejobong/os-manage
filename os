#!/bin/bash

for var in "$@"
do
    option1=${2}
    option2=${3}
    option3=${4}

    helper() {
        echo "Usage: $0 ..."
    }

    banner() {
        clear
        figlet -f standard OpenStack
    }

    if [[ "$var" == "openstack" && "$option1" == "setup" ]]
    then
        clear
        figlet -f standard OpenStack
        echo ""
        echo "Installing Openstack"
        echo ""
        yum install epel-release
        yum update -y

        setenforce 0
        sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
        systemctl stop firewalld
        systemctl stop NetworkManager
        systemctl disable firewalld
        systemctl disable NetworkManager

        yum install -y figlet
        yum install -y centos-release-openstack-train
        yum install -y openstack-packstack
        yum downgrade -y leatherman
        packstack --gen-answer-file=/root/answer.txt

        read -p "Create password login OpenStack Admin Dashboard : " passwd
        
        sed -i "s/^CONFIG_PROVISION_DEMO=.*/CONFIG_PROVISION_DEMO=n/g" /root/answer.txt
        sed -i "s/^CONFIG_KEYSTONE_ADMIN_PW=.*/CONFIG_KEYSTONE_ADMIN_PW=${passwd}/g" /root/answer.txt
        sed -i "s/^CONFIG_HORIZON_SSL=.*/CONFIG_HORIZON_SSL=n/g" /root/answer.txt
        sed -i "s/^CONFIG_NTP_SERVERS=.*/CONFIG_NTP_SERVERS=0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org/g" /root/answer.txt

        packstack --answer-file /root/answer.txt

    elif [[ "$var" == "launch" && "$option1" == "instance" ]]
    then
        banner
    elif [[ "$var" == "server" && "$option1" == "create" ]]
    then
        banner
        echo ""
        echo "SERVER CREATE"
        echo "1. Single Server"
        echo "2. Multiple Server"
        echo ""
        read -p "Input : " sc
        case $sc in
            1)
                banner
                echo ""
                echo "SERVER CREATE"
                echo ""
                read -p "Name Server : " ns
                openstack image list
                read -p "Image : " im
                openstack flavor list
                read -p "Flavor : " fl
                openstack
                read -p "Network : " nw
                openstack server create --image $im --flavor $fl --nic net-id=$nw --wait $ns
            ;;

            2)
                clear
                figlet -f standard OpenStack
                echo ""
                echo "SERVER CREATE"
                echo ""
                read -p "Name Server : " ns
                openstack image list
                read -p "Image : " im
                openstack flavor list
                read -p "Flavor : " fl
                openstack
                read -p "Network : " nw
                read -p "Loop : " a
                for ((i=1; i<=$a; i++))
                do
                    openstack server create --image $im --flavor $fl --nic net-id=$nw --wait $ns$i
                done
            ;;
        esac
    else
        echo "Command not found"
    fi
done
