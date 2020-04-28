#!/bin/bash
touch system_data.rtf

echo "HostName: $(hostname)" | tee -a system_data.rtf
echo "Domain Name: $(domainname)" | tee -a system_data.rtf
echo "Who Am I: $(whoami)" | tee -a system_data.rtf
echo "System Name & Version: $(uname -a)" | tee -a system_data.rtf
printf "\n############## List Logged In Users ####################\n" | tee -a system_data.rtf
echo "$(who -a)" | tee -a system_data.rtf
printf "\n############## List User Accounts ####################\n" | tee -a system_data.rtf
echo "$(cat /etc/passwd)" | tee -a system_data.rtf
printf "\n############## Storage & Memory ####################\n" | tee -a system_data.rtf
printf "-------------- Block/Storage Devices --------------------\n" | tee -a system_data.rtf
echo "$(lsblk -a)" | tee -a system_data.rtf
printf "\n-------------- File System/Partitions --------------------\n" | tee -a system_data.rtf
echo "$(df -h)" | tee -a system_data.rtf
printf "\n-------------- Ram Info --------------------\n" | tee -a system_data.rtf
echo "$(free -m)" | tee -a system_data.rtf
printf "\n-------------- Memory Info --------------------\n" | tee -a system_data.rtf
echo "$(cat /proc/meminfo)" | tee -a system_data.rtf
printf "\n############## Network Info ####################\n" | tee -a system_data.rtf
printf "-------------- Host & Domain Name --------------------\n" | tee -a system_data.rtf
echo "Hostname: $(hostname)" | tee -a system_data.rtf
echo "Domainname: $(domainname)" | tee -a system_data.rtf
printf "\n-------------- Routing Table --------------------\n" | tee -a system_data.rtf
echo "$(route)" | tee -a system_data.rtf
printf "\n-------------- Net Stat (all) --------------------\n" | tee -a system_data.rtf
echo "$(netstat -a)" | tee -a system_data.rtf
printf "\n-------------- Net Stat (Listening) --------------------\n" | tee -a system_data.rtf
echo "$(netstat -lapn)" | tee -a system_data.rtf
printf "\n-------------- Listening Ports --------------------\n" | tee -a system_data.rtf
echo "$(ss -lntu)" | tee -a system_data.rtf
printf "\n-------------- Interface Information(IFCONFIG) --------------------\n" | tee -a system_data.rtf
echo "$(ifconfig -a)" | tee -a system_data.rtf
printf "\n-------------- Interface Information(IP) --------------------\n" | tee -a system_data.rtf
echo "$(ip address)" | tee -a system_data.rtf
printf "\n############## Hardware Info ####################\n" | tee -a system_data.rtf
printf "-------------- CPU Info --------------------\n" | tee -a system_data.rtf
echo "$(lscpu)" | tee -a system_data.rtf
printf "\n-------------- PCI Devices --------------------\n" | tee -a system_data.rtf
echo "$(lspci)" | tee -a system_data.rtf
printf "\n-------------- PCI Devices (Detailed) --------------------\n" | tee -a system_data.rtf
echo "$(lspci -v)" | tee -a system_data.rtf
printf "\n-------------- USB Devices --------------------\n" | tee -a system_data.rtf
echo "$(lsusb)" | tee -a system_data.rtf
printf "\n-------------- USB Devices (Detailed) --------------------\n" | tee -a system_data.rtf
echo "$(lsusb -v)" | tee -a system_data.rtf
printf "\n############## Software Info ####################\n" | tee -a system_data.rtf
printf "-------------- Loadable Kernel Modules --------------------\n" | tee -a system_data.rtf
echo "$(lsmod)" | tee -a system_data.rtf
printf "\n-------------- Startup Programs --------------------\n" | tee -a system_data.rtf
echo "$(ls -lah /etc/init.d/)" | tee -a system_data.rtf
printf "\n-------------- Installed Programs --------------------\n" | tee -a system_data.rtf
echo "$(apt list --installed)" | tee -a system_data.rtf
printf "\n-------------- Services Programs --------------------\n" | tee -a system_data.rtf
echo "$(service --status-all)" | tee -a system_data.rtf
printf "\n-------------- Systemctl Programs --------------------\n" | tee -a system_data.rtf
echo "$(systemctl status --all)" | tee -a system_data.rtf
##printf "\n############## Dmesg Info ####################\n" | tee -a system_data.rtf
##printf "-------------- Dmesg --------------------\n" | tee -a system_data.rtf
##echo "$(dmesg)" | tee -a system_data.rtf
printf "\n############## Process Info ####################\n" | tee -a system_data.rtf
printf "-------------- Current Processes --------------------\n" | tee -a system_data.rtf
echo "$(ps auxwwwf)" | tee -a system_data.rtf
##printf "-------------- Top 5 CPU Processes --------------------\n" | tee -a system_data.rtf
##echo "$(ps auxwwwf | sort -nr -k 3 | head -5)" | tee -a system_data.rtf
##printf "-------------- Top 5 Mem Processes --------------------\n" | tee -a system_data.rtf
##echo "$(ps auxwwwf | sort -nr -k 4 | head -5)" | tee -a system_data.rtf
printf "\n-------------- Arguements of Running Processes --------------------\n" | tee -a system_data.rtf
echo "$(grep -a ^ /proc/*/cmdline)" | tee -a system_data.rtf
##printf "-------------- Cmd History --------------------\n" | tee -a system_data.rtf
##echo "$(history)" | tee -a system_data.rtf

