#!/bin/bash
#Autoscript-Lite By khaiVPN
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -n >/tmp/other.txt
data=($(cat /usr/local/etc/xray/trojanws.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq))
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;48;39m                XRAY Trojan WS User Login                 \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
	fi
	echo -n >/tmp/iptrws.txt
	data2=($(cat /var/log/xray/access3.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq))
	for ip in "${data2[@]}"; do
		jum=$(cat /var/log/xray/access3.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
		if [[ "$jum" = "$ip" ]]; then
			echo "$jum" >>/tmp/iptrws.txt
		else
			echo "$ip" >>/tmp/other.txt
		fi
		jum2=$(cat /tmp/iptrws.txt)
		sed -i "/$jum2/d" /tmp/other.txt >/dev/null 2>&1
	done
	jum=$(cat /tmp/iptrws.txt)
	if [[ -z "$jum" ]]; then
		echo >/dev/null
	else
		jum2=$(cat /tmp/iptrws.txt | nl)
	fi
	echo "User : $akun"
	echo "$jum2"
	echo -e "\033[0;34m
\033[0m"
	rm -rf /tmp/iptrws.txt
	rm -rf /tmp/other.txt
done
echo ""
