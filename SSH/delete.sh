#!/bin/bash
clear
hariini=$(date +%d-%m-%Y)
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;39m    Auto Delete SSH WS AccountSERVER                \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
echo ""
echo "Successfully Remove Expired Account"
echo ""
echo -e "\033[0;34m
\033[0m"
echo -e ""
echo -e "Autoscript By khaiVPN"
echo -e ""
cat /etc/shadow | cut -d: -f1,8 | sed /:$/d >/tmp/expirelist.txt
totalaccounts=$(cat /tmp/expirelist.txt | wc -l)
for ((i = 1; i <= $totalaccounts; i++)); do
	tuserval=$(head -n $i /tmp/expirelist.txt | tail -n 1)
	username=$(echo $tuserval | cut -f1 -d:)
	userexp=$(echo $tuserval | cut -f2 -d:)
	userexpireinseconds=$(($userexp * 86400))
	tglexp=$(date -d @$userexpireinseconds)
	tgl=$(echo $tglexp | awk -F" " '{print $3}')
	while [ ${#tgl} -lt 2 ]; do
		tgl="0"$tgl
	done
	while [ ${#username} -lt 15 ]; do
		username=$username" "
	done
	bulantahun=$(echo $tglexp | awk -F" " '{print $2,$6}')
	echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >>/usr/local/bin/alluser
	todaystime=$(date +%s)
	if [ $userexpireinseconds -ge $todaystime ]; then
		:
	else
		echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >>/usr/local/bin/deleteduser
		echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
		userdel $username
	fi
done
