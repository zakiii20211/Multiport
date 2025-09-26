#!/bin/bash
#Autoscript-Lite By khaiVPN
clear
MYIP=$(wget -qO- ipv4.icanhazip.com)
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/vless.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo -e "\033[0;34m
\033[0m"
	echo -e "\\E[0;41;36m    Check XRAY Vless WS Config     \E[0m"
	echo -e "\033[0;34m
\033[0m"
	echo ""
	echo "You have no existing clients!"
	clear
	exit 1
fi
echo -e "\033[0;34m
\033[0m"
echo -e "\\E[0;41;36m    Check XRAY Vmess WS Config     \E[0m"
echo -e "\033[0;34m
\033[0m"
echo " Select the existing client to view the config"
echo " Press CTRL+C to return"
echo -e "\033[0;34m
\033[0m"
echo "     No  Expired   User"
grep -E "^### " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
	if [[ ${CLIENT_NUMBER} == '1' ]]; then
		read -rp "Select one client [1]: " CLIENT_NUMBER
	else
		read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
done
clear
echo ""
read -p "Bug Address (Example: www.google.com) : " address
read -p "Bug SNI/Host (Example : m.facebook.com) : " hst
bug_addr=${address}.
bug_addr2=${address}
if [[ $address == "" ]]; then
	sts=$bug_addr2
else
	sts=$bug_addr
fi
bug=${hst}
bug2=bug.com
if [[ $hst == "" ]]; then
	sni=$bug2
else
	sni=$bug
fi
user=$(grep -E "^### " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2 | sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VLESS WS None TLS" | cut -d: -f2 | sed 's/ //g')"
domain=$(cat /usr/local/etc/xray/domain)
uuid=$(grep "},{" /usr/local/etc/xray/vless.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(date -d "0 days" +"%Y-%m-%d")
vlesslink1="vless://${uuid}@${sts}${domain}:${tls}?type=ws&encryption=none&security=tls&host=${domain}&path=/vless-tls&allowInsecure=1&sni=${sni}#XRAY_VLESS_TLS_${user}"
vlesslink2="vless://${uuid}@${sts}${domain}:${none}?type=ws&encryption=none&security=none&host=${domain}&path=/vless-ntls#XRAY_VLESS_NON_TLS_${user}"
vlesslink3="vless://${uuid}@162.159.134.61:80?path=/vless-ntls&encryption=none&host=${sts}${domain}&type=ws#DIGI-BOSSTER-${user}"
vlesslink4="vless://${uuid}@172.66.40.170:80?path=/vless-ntls&encryption=none&host=${sts}cdn.opensignal.com.${domain}&type=ws#DIGI-BOSSTER-V2-${user}"
vlesslink5="vless://${uuid}@${domain}:80?path=/vless-ntls&encryption=none&host=m.pubgmobile.com&type=ws#UMOBILE-FUNZ-${user}"
vlesslink6="vless://${uuid}@104.18.8.53:80?path=/vless-ntls&encryption=none&host=${sts}${domain}&type=ws#UMOBILE-${user}"
vlesslink7="vless://${uuid}@104.17.113.188:80?path=/vless-ntls&encryption=none&host=eurohealthobservatory.who.int.${domain}&type=ws#YES-${user}"
vlesslink8="vless://${uuid}@104.17.10.12:80?path=/vless-ntls&encryption=none&host=cdn.who.int.${domain}&type=ws#UNIFI-Bebas-${user}"
vlesslink9="vless://${uuid}@speedtest.unifi.com.my.${domain}:80?path=/vless-ntls&encryption=none&host=&type=ws#Uni5G-${user}"
vlesslink10="vless://${uuid}@104.18.6.178:80?path=/vless-ntls&encryption=none&host=speedtest-univ-results-api.speedtest.net.${domain}&type=ws#MAXIS-FREEZE-${user}"
clear
echo -e ""
echo -e "
[XRAY VLESS WS]"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tls"
echo -e "Port None TLS     : $none"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Network           : WS"
echo -e "Path TLS          : /vless-tls"
echo -e "Path NTLS         : /vless-ntls"
echo -e ""
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link WS TLS       : ${vlesslink1}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link WS None TLS  : ${vlesslink2}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link DIGI-BOSSTER   : ${vlesslink3}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link DIGI-BOSSTER-V2: ${vlesslink4}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link UMOBILE-FUNZ   : ${vlesslink5}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link UMOBILE        : ${vlesslink6}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link YES            : ${vlesslink7}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link UNIFI-Bebas    : ${vlesslink8}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link UNIFI-Uni5G    : ${vlesslink9}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e "Link MAXIS-FREEZE   : ${vlesslink10}"
echo -e "\e[33m═════════════════════════════════\e[m"
echo -e ""
echo -e "YAML WS TLS       : http://${MYIP}:81/$user-VLESSTLS.yaml"
echo -e ""
echo -e "YAML WS None TLS  : http://${MYIP}:81/$user-VLESSNTLS.yaml"
echo -e "\e[33m══════════════════════\e[m"
echo -e "Expired On        : ${user}"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "server            : $User"
echo -e "\e[33m══════════════════════\e[m"
echo -e ""
echo -e "Autoscript By khaiVPN"
echo -e ""
