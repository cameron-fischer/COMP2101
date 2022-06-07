#!/bin/bash
#This script is used to display system info to the user.

#This script assigns the output of the hostname command into a variable which is then displayed.
Hostname=`hostname`

#This script grabs the data from the Fully-qualified Domain Name output and puts it into a variable and displays it.
FQDN=`hostname --fqdn`

#This script finds the os name and version of the system. Once found, this command stores it in a variable and dsiplays it.
Operating_System=`uname -r -o`

#This script finds the IP address of the system shown when the computer is sending or receiving data.

IP_Address=`ip a s ens33 | grep inet -w | awk '{print $2}'`

#This script find the Free space in the Root filesystem and then displays it.

Storage=`df -h | grep /dev/sda3 | awk '{print $4}'`

#Below this text is a output template of what the script output should look like using the cat command.

cat <<EOF

Report for Hostname		: $Hostname
=================================================
FQDN 				: $FQDN
Operating System and Version 	: $Operating_System
IP Address 			: $IP_Address
Root Filesystem Free Space 	: $Storage
=================================================

EOF
