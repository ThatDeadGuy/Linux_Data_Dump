# Linux_Data_Dump
This script dumps a bunch of useful information from a Linux system to assist in penetration testing and system review

Run the bash file as root. It will generate a text file in the current directory named system_data.rtf. The information it will try to gather is as follows:
1)  HostName: $(hostname)
2)  Domain Name: $(domainname)
3) Who Am I: $(whoami)
4) System Name & Version: $(uname -a)
5) List Logged In Users

6) Storage & Memory
   a) Block/Storage Devices
   b) File System/Partitions
   c) Ram Info
   d) Memory Info

7) Network Info
   a) Host & Domain Name
   b) Routing Table
   c) Net Stat (all)
   d) Net Stat (Listening)
   e) Listening Ports - incase Net Stat isn't available
   f) Interface Information(IFCONFIG)
   g) Interface Information(IP)

8) Hardware Info
  a) CPU Info
  b) PCI Devices
  c) PCI Devices (Detailed)
  d) USB Devices
  e) USB Devices (Detailed)

9) Software Info
  a) Loadable Kernel Modules
  b) Startup Programs
  c) Installed Programs
  d) Services Programs
  e) Systemctl Programs
  f) Dmesg Info - currently commented out
  
10) Process Info
  a) Current Processes
  b) Top 5 CPU Processes - currently commented out
  c) Top 5 Mem Processes - currently commented out
  
11) Arguements of Running Processes
12) Cmd History - currently commented out
