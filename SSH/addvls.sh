#!/bin/bash
# //====================================================
# //	System Request:Debian 9+/Ubuntu 18.04+/20+
# //	Author:	Julak Bantur
# //	Dscription: Xray MultiPort
# //	email: putrameratus2@gmail.com
# //  telegram: https://t.me/khaivpn
# //====================================================
# // font color configuration | khaiVPN AUTOSCRIPT
###########- COLOR CODE -##############
VC="\e[0m"
Green="\e[92;1m"
BICyan='\033[1;96m'
BIYellow='\033[1;93m'
WH='\033[1;37m'
y='\033[1;33m' #yellow
l='\033[0;37m'
BGX="\033[42m"
CYAN="\033[96m"
z="\033[96m"
zx="\033[97;1m" # // putih
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[0;34m"
green='\033[1;32m'
grenbo="\e[92;1m"
purple="\033[1;95m"
YELL='\033[0;33m'
cyan="\033[1;36m"
c="\033[5;33m"
###########- END COLOR CODE -##########
# Getting
export CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
export KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
#IZIN SCRIPT
clear
PUB=$(cat /etc/slowdns/server.pub)
NS=$(cat /etc/xray/dns)
domain=$(cat /etc/xray/domain)
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
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#none$/a\### '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
#JanganLupaMakanYa
mv /usr/local/etc/xray/$user-VLESS-WS.yaml /home/vps/public_html/$user-VLESS-WS.yaml
vlesslink1="vless://${uuid}@${sts}${domain}:$tls?type=ws&encryption=none&security=tls&host=${sts}${domain}&path=$patch&allowInsecure=1&sni=$sni#VLESS-TLS-${user}"
vlesslink2="vless://${uuid}@${sts}${domain}:$none?type=ws&encryption=none&security=none&host=$sni&path=$patch#VLESS-NTLS-${user}"
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


END

systemctl restart xray@vless
systemctl restart xray@vnone
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
echo -e "Limit Quota : ${Quota} GB"
echo -e "Port TLS      : 443"
echo -e "Port gRPC     : 443"
echo -e "Port None TLS : 80"
#echo -e "Port XrayDns  : 443,5300,53,80"
echo -e "User ID       : ${uuid}"
echo -e "Encryption    : none"
echo -e "Path          : /vless"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link TLS    :"
echo -e "${vlesslink1}"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link NTLS   :"
echo -e "${vlesslink2}"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Link Yaml : http://$MYIP:81/$user-VLESS-WS.yaml"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\e[$line══════════════════════\e[m"
echo -e "Name      : ${user}"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "SerVer    : $creditt"
echo -e "User ID   : ${uuid}"
echo -e "\e[$line══════════════════════\e[m"
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        Script By khaiVPN             "
echo -e "${z}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
m-vless
