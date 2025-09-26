#!/bin/bash

clear
echo -e "\e[33m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[1;47;39m      Check Multilogin SSH WSSERVER                \E[0m"
echo -e "\e[33m╘════════════════════════════════════════════╛\033[0m"
if [ -e "/root/log-limit.txt" ]; then
	echo "User Who Violate The Maximum Limit"
	echo "Time - Username - Number of Multilogin"
	echo -e "\033[0;34m
\033[0m"
	cat /root/log-limit.txt
else
	echo " No user has committed a violation"
	echo " "
	echo " or"
	echo " "
	echo " The user-limit script not been executed."
	echo " "
	echo -e "\033[0;34m
\033[0m"
	echo -e ""
	echo -e "Autoscript By khaiVPN"
	echo -e ""
fi
