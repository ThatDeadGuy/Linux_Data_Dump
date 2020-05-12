# Linux_Data_Dump
This script dumps a bunch of useful information from a Linux system to assist in penetration testing and system review

Run the bash file as root. It will generate a text file in the current directory named system_data.rtf. The information it will try to gather is as follows:

System_Data File
1)  HostName
2)  Host IP
3)  Domain Name
4)  Connectivity Check 
5)  Who Am I
6)  Uptime
7)  System Name & Version
8)  Distributer Description Release
9)  List Logged In Users
10) Last 10 logins
11) Currently Connected
12) List User Accounts
13) List Sudoers File
14) Available Shells
15) Environment Variables


Memory Data File
1) Block/Storage Devices
2) Find Mounted File Systems
3) File System/Partitions
4) Ram Info
5) Memory Info
6) Find Hidden Directories


Network Info File
1)  Host & Domain Name
2)  Connectivity Check
3)  Interface Information (ifconfig)
4)  Interface Information (IP)
5)  Routing Table
6)  IP Tables
7)  ARP Tables
8)  Net Stat (all)
9)  Net Stat (Listening)
10) Listening Ports (ss -lntu)- incase Net Stat isn't available
11) Current Connections (ss -s)
12) UFW Firewall Rules Verbose
13) UFW Firewall Rules Numbered


Hardware Info File
1) CPU Info
2) Device List
3) PCI Devices
4) PCI Devices (Detailed)
5) USB Devices
6) USB Devices (Detailed)


Software Info File
1) Configurable Common Packages Search
2) Loadable Kernel Modules
3) Startup Programs
4) Installed Programs
5) Services Programs
6) Systemctl Programs
7) Dmesg Info - currently commented out
  
  
Process Info File
1) Top 5 CPU Processes - currently commented out
2) Top 5 Mem Processes - currently commented out
3) Current Processes
4) Directory of Running Processes
5) Executable of Running Processes
6) Arguements of Running Processes
7) Deleted Binaries Still Running
8) Cmd History Files
9) Cmd History - currently commented out


Password Data File
1) Search for Clear Text Passwords - currently commented out, the search takes a long time on large systems
2) Additional Search for Clear Text Passwords
3) Search for Passwords in Memory

Misc Data File
1) Search for SUID Binaries
2) Search for SGID Binaries
3) Binaries of Interest
4) World Writable Files 1
5) World Writable Files 2
6) World Writable Files 3
7) List Cron Jobs

++++ Honey Do List ++++
Docker information search


Zip the files and clean up the directory
