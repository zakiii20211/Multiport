## Commands : <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=powershell&label=Shell&message=Bash%20Script&color=lightgray">

## For Debian 10 / 11 / 12 For First Time Installation (Update Repo)

```html
  apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
```

## For Ubuntu 18.04 / 20.04 / 22.04 / 24.04 For First Time Installation (Update Repo)

  ```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && reboot
```

## INSTALLATION SCRIPT

  ```html
apt --fix-missing update && apt update && apt upgrade -y && apt install -y bzip2 gzip coreutils screen dpkg wget vim curl nano zip unzip && wget -q https://raw.githubusercontent.com/zakiii20211/Multiport/main/V1/setup-lite.sh && chmod +x setup-lite.sh && screen -S setup-lite ./setup-lite.sh

```
