#!/bin/bash

#Autoscript-Lite By khaiVPN
P='\e[0;35m'
B='\033[0;36m'
G='\e[0;32m'
N='\e[0m'

clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
#########################
MYIP=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $2}')
clear
RED='\e[1;31m'
GREEN='\e[0;32m'
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'

purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
clear
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "                 MENU helium              $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "  ${ORANGE}1.${NC} \033[0;36m INSTALL/HELIUM${NC}"
echo -e "  ${ORANGE}2.${NC} \033[0;36m helium${NC}"
echo -e "  ${ORANGE}0.${NC} \033[0;36m menu${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e ""
read -p "Select From Options [ 1 - 5 ] : " menu
case $menu in
1)  clear ;
    rm -rf /usr/local/sbin/helium && wget -q -O /usr/local/sbin/helium https://raw.githubusercontent.com/abidarwish/helium/main/helium.sh && chmod +x /usr/local/sbin/helium && helium
    ;;
2) clear ;
    helium
    ;;
0)
    menu
    ;;
esac