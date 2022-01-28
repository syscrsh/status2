#!/bin/bash
exec 2>/dev/null
NC='\033[0m'
BLACK='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'

function printheader {
    printf ${PURPLE}
    echo '         __        __            ___          __'
    echo '   _____/ /_____ _/ /___  ______|__ \   _____/ /_'
    echo '  / ___/ __/ __ `/ __/ / / / ___/_/ /  / ___/ __ \'
    echo ' (__  ) /_/ /_/ / /_/ /_/ (__  ) __/_ (__  ) / / /'
    echo '/____/\__/\__,_/\__/\__,_/____/____(_)____/_/ /_/'
    echo '-------------------------------------------------'
    printf ${NC}
    echo '[+] version 1.0                     December 2021'
}

function printbanner () {
    case $1 in
        *"devbox"*)
        printf ${RED}
        echo '       __          __'
        echo '  ____/ /__ _   __/ /_  ____  _  __'
        echo ' / __  / _ \ | / / __ \/ __ \| |/_/'
        echo '/ /_/ /  __/ |/ / /_/ / /_/ />  <'  
        echo '\__,_/\___/|___/_.___/\____/_/|_|'  
        printf ${NC}
        ;;
    esac
}

# user info
username=$(whoami)
hostname=$(uname -n)
shell=$(echo $SHELL)

# os info
kernel=$(uname -r)
date=$(date)
package_count=$(dpkg-query -l |grep -c '^ii')
dist_name=$(cat /etc/os-release |head -n1 |cut -d'"' -f 2)
dist_version=$(cat /etc/os-release |sed -n 2p |cut -d'"' -f 2)
uptime=$(uptime -p)
ip_addr=$(hostname -I |awk '{print $1}')

# machine info
cpu_info=$(cat /proc/cpuinfo |grep 'model name' |head -n1 |cut -d' ' -f 3-)
mobo_vendor=$(head /sys/devices/virtual/dmi/id/board_vendor)
mobo_name=$(head /sys/devices/virtual/dmi/id/board_name)
mem_total=$(free -mh |awk 'NR==2 {print $2}')
mem_used=$(free -mh |awk 'NR==2 {print $3}')
swap_total=$(free -mh |awk 'NR==3 {print $2}')
swap_used=$(free -mh |awk 'NR==3 {print $3}')
coretemp_0=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 1p)
coretemp_1=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 2p)
coretemp_2=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 3p)
coretemp_3=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 4p)
coretemp_4=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 5p)
coretemp_5=$(sensors |grep -w 'Core' |awk '{print $1,$2,$3}' |sed -n 6p)

# disk info
disk_header=$(df -h |head -n1)
disk_root=$(df -h |grep -w '/')
disk_server=$(df -h |grep -w '/srv')
disk_home=$(df -h |grep -w '/home')

# print all the things !
printheader
printbanner $hostname
echo -e "\n${YELLOW}[+] user info${NC}\n"                                   \
        "\t${CYAN}username${NC} :  ${GREEN}$username${NC}\n"                \
        "\t${CYAN}hostname${NC} :  ${GREEN}$hostname${NC}\n"                \
        "\t${CYAN}shell${NC}    :  ${GREEN}$shell${NC}\n"                   \
        "${YELLOW}[+] os info${NC}\n"                                       \
        "\t${CYAN}distro${NC}   :  ${GREEN}$dist_name $dist_version${NC}\n" \
        "\t${CYAN}kernel${NC}   :  ${GREEN}$kernel${NC}\n"                  \
        "\t${CYAN}uptime${NC}   :  ${GREEN}$uptime${NC}\n"                  \
        "\t${CYAN}time${NC}     :  ${GREEN}$date${NC}\n"                    \
        "\t${CYAN}packages${NC} :  ${GREEN}$package_count${NC}\n"           \
        "\t${CYAN}ip addr${NC}  :  ${GREEN}$ip_addr${NC}\n"                 \
        "${YELLOW}[+] hardware info${NC}\n"                                 \
        "\t${CYAN}cpu${NC}      :  ${GREEN}$cpu_info${NC}\n"                \
        "\t${CYAN}temp${NC}     :  ${GREEN}$coretemp_0${NC}\n"              \
        "\t\t :  ${GREEN}$coretemp_1${NC}\n"                                \
        "\t\t :  ${GREEN}$coretemp_2${NC}\n"                                \
        "\t\t :  ${GREEN}$coretemp_3${NC}\n"                                \
        "\t\t :  ${GREEN}$coretemp_4${NC}\n"                                \
        "\t\t :  ${GREEN}$coretemp_5${NC}\n"                                \
        "\t${CYAN}board${NC}    :  ${GREEN}$mobo_vendor $mobo_name${NC}\n"  \
        "\t${CYAN}memory${NC}   :  ${GREEN}$mem_total${NC}\n"               \
        "\t${CYAN}used${NC}     :  ${GREEN}$mem_used${NC}\n"                \
        "\t${CYAN}swap${NC}     :  ${GREEN}$swap_total${NC}\n"              \
        "\t${CYAN}used${NC}     :  ${GREEN}$swap_used${NC}\n"               \
        "${YELLOW}[+] disk info${NC}\n"                                     \
        "\t${CYAN}$disk_header\n"                                           \
        "\t${GREEN}$disk_root${NC}\n"                                      
