#!/bin/bash
#These commands identify the host name of the computer.
echo -n 'Host Name: ' 
hostname
#These commands identify the domain name of the computer if there is any.
echo -n 'Domain Name: '
domainname
#This command pulls the operating system info, isolating the name and version of the system.
echo -n 'OS Version: '
cat /etc/os-release | grep PRETTY_NAME /etc/os-release 
#This command pulls the generic IP info of the computer. Then isolated the IPV4 address.
echo -n 'IP Address ' 
ip a s ens33 |grep -w inet |awk '{print $2}'
#This command pulls the storage data of the device, while isolating the Root Filesystem info.
echo 'Root Filesystem Storage: '
echo 'Filesystem      Size  Used Avail Mouted on'
df -h| 
grep /dev/sda3
