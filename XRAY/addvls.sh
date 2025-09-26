#!/bin/bash
#Autoscript-Lite By khaiVPN
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
#########################
MYIP=$(curl -sS https://raw.githubusercontent.com/zakiii20211/Multiport/main/LICENSE/access | awk '{print $2}')
clear
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
fi

clear
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e " CREATE VLESS ACCOUNT           "
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

  read -rp "User: " -e user
  CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e " CREATE VLESS ACCOUNT           "
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo "A client with the specified name was already created, please choose another name."
    echo ""
    echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
  fi
done
#JanganLupaMakanYa
read -p "Uuid (Manual): " uuid
read -p "Expired (days): " masaaktif
#read -p "Bug (Host): " bug
#read -p "Limit User (IP): " iplimit
#read -p "Limit User (GB): " Quota
#JanganLupaMakanYa
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
sed -i '/#vless$/a\#& '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
sed -i '/#vlessgrpc$/a\#vlg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
#JanganLupaMakanYa
systemctl restart xray@vless.service
systemctl restart xray@vnone.service
service cron restart
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&host=${domain}&type=ws&sni=${bug}#${user}"
vlesslink2="vless://${uuid}@${bug}:80?path=/vless&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${bug}#${user}"
cat >/home/vps/public_html/$user-VLESSTLS.yaml <<EOF
#JanganLupaMakanYa
if [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
fi

if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/kyt/limit/vless/ip
echo -e "$iplimit" > /etc/kyt/limit/vless/ip/$user
else
echo > /dev/null
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vless/${user}
fi
DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi
echo "### ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vless/.vless.db
clear
cat >/var/www/html/vless-$user.txt <<-END

---------------------
Format Vless WS TLS
---------------------
- name: Vless-$user-WS TLS
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}

---------------------
Format Vless WS Non TLS
---------------------
- name: Vless-$user-WS (CDN) Non TLS
  server: ${domain}
  port: 80
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}
  udp: true

---------------------
Format Vless gRPC (SNI)
---------------------
- name: Vless-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: grpc
  grpc-opts:
  grpc-mode: gun
    grpc-service-name: vless-grpc

---------------------
Link Akun Vless 
---------------------
Link TLS      : 
${vlesslink1}
---------------------
Link none TLS : 
${vlesslink2}
---------------------
Link GRPC     : 
${vlesslink3}
---------------------


END

systemctl restart xray@vless.service
systemctl restart xray@vnone.service
service cron restart
clear
echo -e ""
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " CREATE VLESS ACCOUNT           "
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Remarks       : ${user}"
echo -e "Host          : ${domain}"
#echo -e "Host XrayDns  : ${NS}"
#echo -e "Public Key    : ${PUB}"
echo -e "Limit Ip      : ${iplimit} Login"
#echo -e "Limit Quota : ${Quota} GB"
echo -e "Port TLS      : 443"
echo -e "Port gRPC     : 443"
echo -e "Port None TLS : 80"
#echo -e "Port XrayDns  : 443,5300,53,80"
echo -e "User ID       : ${uuid}"
echo -e "Encryption    : none"
echo -e "Path TLS      : /vless-tls"
echo -e "Path NTLS     : /vless-ntls"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link TLS    :"
echo -e "${vlesslink1}"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link NTLS   :"
echo -e "${vlesslink2}"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link GRPC   :"
echo -e "${vlesslink3}"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Format OpenClash : https://${domain}:81/vless-$user.txt"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Masa Aktif    : $expe"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "              Script By khaiVPN              "
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vless