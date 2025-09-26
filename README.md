## Commands : <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=powershell&label=Shell&message=Bash%20Script&color=lightgray">

## Update & Upgrade First Your VPS for Debian 10 & 11

```html
  apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
```

## Update & Upgrade First Your VPS for Ubuntu 18.04 & 20.04

```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && reboot
```

## INSTALLATION SCRIPT
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/KhaiVpn767/MultiportV3/main/V1/setup-lite.sh && chmod +x setup-lite.sh && sed -i -e 's/\r$//' setup-lite.sh && screen -S setup ./setup-lite.sh
```
