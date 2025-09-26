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

cek=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $2}' | grep $MYIP)
Name=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | grep $MYIP | awk '{print $4}')
if [[ $cek = $MYIP ]]; then
	echo -e "${green}Permission Accepted...${NC}"
else
	echo -e "${red}Permission Denied!${NC}"
	echo ""
	echo -e "Your IP is ${red}NOT REGISTER${NC} @ ${red}EXPIRED${NC}"
	echo ""
	echo -e "Please Contact ${green}Admin${NC}"
	echo -e "Telegram : t.me/zakiii20211"
	exit 0
	clear
fi

BURIQ() {
	curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access >/root/tmp
	data=($(cat /root/tmp | grep -E "^### " | awk '{print $4}'))
	for user in "${data[@]}"; do
		exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
		d1=($(date -d "$exp" +%s))
		d2=($(date -d "$biji" +%s))
		exp2=$(((d1 - d2) / 86400))
		if [[ "$exp2" -le "0" ]]; then
			echo $user >/etc/.$user.ini
		else
			rm -f /etc/.$user.ini >/dev/null 2>&1
		fi
	done
	rm -f /root/tmp
}

MYIP=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $2}')
Name=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | grep $MYIP | awk '{print $4}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)
Bloman() {
	if [[ -f "/etc/.$Name.ini" ]]; then
		CekTwo=$(cat /etc/.$Name.ini)
		if [[ "$CekOne" = "$CekTwo" ]]; then
			res="Expired"
		fi
	else
		res="Permission Accepted..."
	fi
}

PERMISSION() {
	MYIP=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $2}')
	IZIN=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $3}' | grep $MYIP)
	if [[ "$MYIP" = "$IZIN" ]]; then
		Bloman
	else
		res="Permission Denied!"
	fi
	BURIQ
}

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

if [ "$res" = "Expired" ]; then
	Exp="\e[36mExpired\033[0m"
	rm -f /home/needupdate >/dev/null 2>&1
else
	Exp=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | grep $MYIP | awk '{print $3}')
fi

clear
domain=$(cat /usr/local/etc/xray/domain)
User=$(cat /usr/local/etc/xray/user)

# // nginx status
nginx=$(systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')
if [[ $nginx == "running" ]]; then
	status_nginx="${GREEN}ON${NC}"
else
	status_nginx="${RED}OFF${NC}"
fi

# // xray status
xray=$(systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')
if [[ $xray == "running" ]]; then
	status_xray="${GREEN}ON${NC}"
else
	status_xray="${RED}OFF${NC}"
fi

# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"

# // script version
myver="$(cat /home/ver)"
# // script version check
serverV=$(curl -sS https://raw.githubusercontent.com/zakiii20211/ScriptVersion/main/ssh_websocket_lite)
# // update script if available
function updatews() {
	clear
	echo -e "[ ${GREEN}INFO${NC} ] Check for Script updates . . ."
	sleep 1
	wget -q -O /root/update-ssh.sh "https://raw.githubusercontent.com/zakiii20211/ScriptVersion/main/update-ssh.sh" && chmod +x update-ssh.sh && ./update-ssh.sh
	sleep 1
	rm -f /root/update-ssh.sh
	rm -f /home/ver
	version_check=$(curl -sS https://raw.githubusercontent.com/zakiii20211/ScriptVersion/main/ssh_websocket_lite)
	echo "$version_check" >>/home/ver
	clear
	echo ""
	echo -e "[ ${GREEN}INFO${NC} ] Successfully Up To Date!"
	sleep 1
	echo ""
	read -n 1 -s -r -p "Press any key to continue..."
	menu
}

# // Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
# // Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
# // Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;30m                 INFO SERVER                \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
tram=$(free -h | awk 'NR==2 {print $2}')
uram=$(free -h | awk 'NR==2 {print $3}')
uphours=$(uptime -p | awk '{print $2,$3}' | cut -d , -f1)
upminutes=$(uptime -p | awk '{print $4,$5}' | cut -d , -f1)
uptimecek=$(uptime -p | awk '{print $6,$7}' | cut -d , -f1)
cekup=$(uptime -p | grep -ow "day")
IPVPS=$(curl -s icanhazip.com/ip)
nsdomain1=$(cat /root/nsdomain)
if [ "$cekup" = "day" ]; then
	echo -e " System Uptime   :  $uphours $upminutes $uptimecek"
else
	echo -e " System Uptime   :  $uphours $upminutes"
fi
echo -e " Memory Usage    :  $uram / $tram"
echo -e " CPU Usage       :  $cpu_usage"
echo -e " VPN Core        :  XRAY-CORE"
echo -e " Domain          :  $domain"
echo -e " Name Server(NS) :  $nsdomain1"
echo -e " IP VPS          :  $IPVPS"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e "     [ XRAY-CORE${NC} : ${status_xray} ]   [ NGINX${NC} : ${status_nginx} ]"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e "  \033[1;33mSSH XRAY WEBSOCKET MULTIPORT BY KhaiVpn\033[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[33m Traffic\e[0m     ${P}Today     Yesterday     Month     ${N}"
echo -e "\e[33m Download\e[0m   $dtoday    $dyest     $dmon       "
echo -e "\e[33m Upload\e[0m     $utoday    $uyest     $umon       "
echo -e "\e[33m Total\e[0m      ${B}$ttoday    $tyest     $tmon       ${N}"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;30m                 XRAY MENU                  \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m
[\033[1;33m•1\033[0m]  XRAY Vmess Websocket Panel
[\033[1;33m•2\033[0m]  XRAY Vless Websocket Panel
[\033[1;33m•3\033[0m]  XRAY Trojan Websocket Panel
[\033[1;33m•4\033[0m]  SSH Websocket Panel"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;30m                OTHERS MENU                 \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m
[\033[1;33m•5\033[0m]  Install TCP BBR
[\033[1;33m•6\033[0m]  Limit Bandwith Speed"
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;30m                SYSTEM MENU                 \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m
""
[\033[1;33m•7\033[0m]  Change Domain
[\033[1;33m•8\033[0m]  Renew Certificate XRAY
[\033[1;33m•9\033[0m]  Check VPN Status
[\033[1;33m10\033[0m]  Check VPN Port
[\033[1;33m11\033[0m]  Restart VPN Services
[\033[1;33m12\033[0m]  Speedtest VPS
[\033[1;33m13\033[0m]  Check RAM
[\033[1;33m14\033[0m]  Check Bandwith
[\033[1;33m15\033[0m]  DNS Changer
[\033[1;33m16\033[0m]  Netflix Checker
[\033[1;33m17\033[0m]  Backup
[\033[1;33m18\033[0m]  Restore
[\033[1;33m19\033[0m]  Reboot
[\033[1;33m20\033[0m]  Menu Helium
[\033[1;33m21\033[0m]  update"
echo ""
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " Version       :\033[1;36m SSH XRAY WS Multiport : v3\e[0m"
echo -e " Client Name   : $User"
echo -e " Expiry Script : $Exp"
echo -e " Status Script : ${G}$Name${NC}"
echo -e " License Key   : ${P}$MYIP${NC}"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
echo ""
echo -ne " Select menu : "

read opt
case $opt in
1)
	clear
	menu-ws
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
2)
	clear
	menu-vless
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
3)
	clear
	menu-tr
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
4)
	clear
	menu-ssh
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
5)
	clear
	bbr
	menu
	;;
6)
	clear
	limit
	echo ""
	menu
	;;
7)
	clear
	add-host
	menu
	;;
8)
	clear
	certxray
	menu
	;;
9)
	clear
	status
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
10)
	clear
	info
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
11)
	clear
	restart
	menu
	;;
12)
	clear
	speedtest
	echo ""
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
13)
	clear
	ram
	echo ""
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
14)
	clear
	vnstat
	echo ""
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
15)
	clear
	dns
	echo ""
	menu
	;;
16)
	clear
	nf
	echo ""
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
17)
	clear
	backup
	read -n1 -r -p "Press any key to continue..."
	menu
	;;
18)
	clear
	restore
	menu
	;;
19)
	clear
	reboot
	;;
20)
	clear
	menu-helium.sh
	;;
21)
	clear
	updatefile.sh
	;;
00 | 0)
	clear
	menu
	;;
*)
	clear
	menu
	;;
esac
