#!/bin/bash

# Current Author: That Dead Guy
# A modified version of Gary Hooks' work sys_info.sh:
# 	Original Author: Gary Hooks
# 	Web: http://www.twintel.co.uk
# Supporting input from:
#	MYero
#	JGuz
#	SANDFLY SECURITY Linux Compromise Assessment Cmd Cheat Sheet
# Publish Date: 13th May 2020
# Version: 1.2
# Licence: GNU GPL 

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
folderName="${current_time}_Linux_Data_Dump"
mkdir "$folderName"
OutputFileName="${current_time}_Linux_Data_Dump.rtf"
DEL_RUNNING="\b\b\b\b\b\b\b\b"
CLEAR_EOL=$(tput el)

# First Param: System Name
# Second Param: String describing the overall contents of the file
# Example Useage: insertHeader "MaxEdge" "Passwords in clear text" 
function insertHeader()
{
	printf "########################################################################\n" | tee -a $CURRENT_FILE
	printf "###                  Linux Data Dump (Version 1.2)                   ###\n" | tee -a $CURRENT_FILE
	printf "###                       $1                      ###\n" | tee -a $CURRENT_FILE
	printf "###                       $2                        ###\n" | tee -a $CURRENT_FILE
	printf "########################################################################\n\n" | tee -a $CURRENT_FILE
}

# First Param: Subsection title
# Example usage: insertPartition "ARP Tables"
function insertPartition()
{
    printf -- "\n----------------------------$1----------------------------------------\n" | tee -a $CURRENT_FILE
}

# First Param: String with Descriptive Title
# Second Param: String with actual command
# Example Usage: runTest "List of Files in Current Folder" "ls -lah"

function runTest()
{
    NAME_OF_TEST=$1
    COMMAND_TO_RUN=$2
    printf "$1 - Running"
    insertPartition $1
    printf "($2)\n" >> $CURRENT_FILE
    eval $2 >> $CURRENT_FILE
    printf "\n\n" >> $CURRENT_FILE
    printf "$DEL_RUNNING Saved$CLEAR_EOL\n"
}

echo "Project Name: "
read projectName

##++++++++++++++++ System Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/system_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "General_Information"
runTest "Host_Name" "hostname"
runTest "Host_IP" "hostname -I"
runTest "Domain_Name" "domainname"
runTest "Connectivity_Check" "ping -c 4 8.8.8.8"
runTest "Who_Am_I" "whoami"
runTest "Uptime" "uptime"
runTest "System_Name_&_Version" "uname -a"
COMMAND_STRING='lsb_release -a 2>/dev/null | grep -E "Distributor|Description|Release"'
insertPartition "Distributer,_Description,_Release"
printf "($COMMAND_STRING)\n" >> $CURRENT_FILE
eval $COMMAND_STRING >> $CURRENT_FILE
printf "\n\n" >> $CURRENT_FILE
runTest "Logged_In_Users" "who -a"
#Last Logins list length; Full List: last -a; 
runTest "Last_10_Logins" "last -a | head -10"
runTest "Currently_Connected" "w"
runTest "List_User_Accounts" "cat /etc/passwd"
runTest "List_Sudoers_File" "cat /etc/sudoers"
runTest "Available_Shells" "cat /etc/shells | tail -n +2"
runTest "Environment_Variables" "env"


##++++++++++++++++ Memory Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/memory_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Storage_&_Memory_Data"
runTest "Block_&_Storage_Devices" "lsblk -a"
runTest "Find_Mounted_Filesystems" "findmnt -A"
runTest "File_System_&_Partitions" "df -h"
runTest "Ram_Info" "free -m"
runTest "Memory_Info" "cat /proc/meminfo"
runTest "Find_Hiden_Directories" 'find / -type d -name".*"'

##++++++++++++++++ Network Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/network_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Network_Info"
runTest "Host_Name" "hostname"
runTest "Domain_Name" "domainname"
runTest "Connectivity_Check" "ping -c 4 8.8.8.8"
runTest "Interface_Information(IFCONFIG)" "ifconfig -a"
runTest "Interface_Information(IP)" "ip address"
runTest "Routing_Table" "route -n"
runTest "IP_Tables" "iptables -t nat -vnL"
runTest "ARP_Table" "arp -a"
runTest "Net_Stat_(all)" "netstat -a"
runTest "Net_Stat_(Listening)" "netstat -lapn"
runTest "Listening_Ports" "ss -lntu"
runTest "Current_Connections" "ss -s"
runTest "Resolve_Conf" "cat /etc/resolv.conf"
###runTest "Firewall_Rules" "firewall-cmd --list-all"
runTest "UFW_Firewall_Rules_Verbose" "ufw status verbose"
runTest "UFW_Firewall_Rules_Numbered" "ufw status numbered"

##++++++++++++++++ Hardware Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/hardware_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Hardware_Info"
runTest "CPU_Info" "lscpu"
insertPartition "Device_List"
row_count=$(lspci | wc -l)
for (( c=1; c<=${row_count}; c++ ))
do
	lspci| sed  "${c}q;d" | cut -c 9- | tee -a $CURRENT_FILE
done
runTest "PCI_Devices" "lspci"
runTest "PCI_Devices_(Detailed)" "lspci -v"
runTest "USB_Devices" "lsusb"
runTest "USB_Devices_(Detailed)" "lsusb -v"
###runTest "Dmesg_Info" "dmesg"


##++++++++++++++++ Software Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/software_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Software_Info"
insertPartition "Common_Packages"
#checks if packages in the list are installed and tells thier version
packages=("python" "python3" "mysql" "ruby" "perl" "bash" "ssh" "telnet")
#packages can be added above to search more packages
for i in "${packages[@]}"
do
    version=$(apt-cache show $i 2>/dev/null | grep -m 1 Version | wc -l )
    DETAIL="NOT INSTALLED"
	if [ $version == 1 ]
	then    #if the package is installed, show the version
		DETAIL=$(apt-cache show $i 2>/dev/null | grep -m 1 Version | awk '{ printf "VERSION:" $2 "\n" }' )
	fi
	printf "PACKAGE:${i}\t $DETAIL \n" | tee -a $CURRENT_FILE
done
runTest "Loadable_Kernel_Modules" "lsmod"
runTest "Startup_Programs" "ls -lah /etc/init.d/"
runTest "Installed_Programs" "apt list --installed"
runTest "Services_Programs" "service --status-all"
runTest "Systemctl_Programs" "systemctl status --all"

##++++++++++++++++ Process Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/process_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Process Info"
runTest "Top_5_CPU_Processes" "ps auxwwwf | sort -nr -k 3 | head -5"
runTest "Top_5_Mem_Processes" "ps auxwwwf | sort -nr -k 4 | head -5"
runTest "Current_Processes" "ps auxwwwf"
runTest "Directory_of_Running_Processes" "ls -l /proc/*/cwd"
runTest "Executable_of_Running_Processes" "ls -l /proc/*/exe"
runTest "Arguements_of_Running_Processes" "grep -a ^ /proc/*/cmdline"
runTest "Deleted_Binaries_Still_Running" "ls -aIR /proc/*/exe 2>/dev/null | grep deleted"
# Running from tmp and dev need more testing/verification of functionality
#runTest "Proccesses Running From tmp" "ls -aIR /proc/*/cwd 2>/dev/null | grep tmp"
#runTest "Proccesses Running From dev" "ls -aIR /proc/*/cwd 2>/dev/null | grep dev"
runTest "Cmd_History_Files" "find / -name *.history"
runTest "Cmd_History" "history"

##++++++++++++++++ Password Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/password_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Passwords"

#This search for clear text passwords TAKES A LONG TIME
#COMMAND_STRING='grep -rnw "/" -ie "PASSWORD" 2> /dev/null'
#insertPartition "Clear_Text_Passwords"
#printf "($COMMAND_STRING)\n" >> $CURRENT_FILE
#eval $COMMAND_STRING >> $CURRENT_FILE
#printf "\n\n" >> $CURRENT_FILE

runTest "More_Clear_Text_Passwords" 'find . -type f -exec grep -i -I "PASSWORD" {} /dev/null \;'
runTest "Passwords_In_Memory" 'strings /dev/mem -n10 | grep -i PASS'

##++++++++++++++++ Misc Data.rtf+++++++++++++++++++++++
CURRENT_FILE=$folderName/misc_data.rtf
touch $CURRENT_FILE
insertHeader $projectName "Misc_Data"
runTest "SUID_Binaries" "find / -perm -4000 -type f -exec ls -la {} 2>/dev/null"
runTest "SGID_Binaries" "find / -perm -2000 -type f -exec ls -la {} 2>/dev/null"
runTest "Binaries_Of_Interest" "find / -uid 0 -perm -4000 -type f 2>/dev/null"
runTest "World_Writable_Files" "find / -writable ! -user `whoami` -type f ! -path "/proc/*" ! -path "/sys/*" -exec ls -al {} \; 2>/dev/null"
runTest "World_Writable_Files" "find / -perm -2 -type f 2>/dev/null"
runTest "World_Writable_Files" "find / ! -path "*/proc/*" -perm -2 -type f -print 2>/dev/null"
runTest "Crontab_Jobs" "crontab -l"

## Collect Logs: find /var/log -mtime -$logDate -exec cp {} $tmp/logs/ \; nested folders are huge!!


##++++++++++++++++ Docker Data.rtf+++++++++++++++++++++++
## CURRENT_FILE=$folderName/docker_data.rtf
## touch $CURRENT_FILE
## insertHeader $projectName "Docker_Container_Enumeration"
        
## runTest "" ""     https://docs.docker.com/engine/reference/commandline/container_ls/


##++++++++++++++++ Zip Data and Remove Files +++++++++++++++++++++++
CURRENT_FILE=$folderName/system_data.rtf
DATE=$(date +"%d %B %Y")
TIME=$(date +"%T")
CURRENT_PATH=$(pwd)
printf "\n\n" | tee -a $CURRENT_FILE
printf "Process Completed\n" | tee -a $CURRENT_FILE
printf -- "------------------------------------\n" | tee -a $CURRENT_FILE
printf "End Time: \t $TIME\n" | tee -a $CURRENT_FILE
printf "End Date: \t $DATE\n" | tee -a $CURRENT_FILE
printf "\n\n" | tee -a $CURRENT_FILE

## END ##
FINAL_PATH="$CURRENT_PATH/$folderName.tgz"
printf "Compressing Results into Package\n\n"
tar -czvf $FINAL_PATH $folderName/*
printf "\nCleaning up\n\n"
rm -rf $folderName
printf "Results will be stored here: \t $FINAL_PATH \n\n"
