#!/bin/bash
#This script is used to initialize lxd services, create a suitable network bridge, and create a lxd container to run a virtual server in.

#This script segment checks if a container already exists. If it does, the script is skipped. If it does not exist, an installer is ran.

snap list | grep -w lxd
if test $? -eq 0; then
	echo "Container already exists." ;
else
	echo"Installing lxd..."
	sudo apt install lxd
	echo "lxd successfully installed"
	fi

#This script will determine whether LXD is initialized or not. If initialized it is skipped 
ip a | grep -q lxdbr0
if [ $? -eq 0 ]; then
echo "lxd is running"

else
	echo "lxd is not running. Initializing..."
	lxd init auto
	fi

#This script checks if COMP2101-S22 and the IP address associated with it are present in the appropriate /etc/hosts file.
cat /etc/hosts | grep -w COMP2101-S22
if test $? -eq ; 
	then echo "COMP2101-S22 and the IP address associated are present" ;

else
IPaddress=$(lxc info COMP2101-S22 | grep inet: | grep global | awk '{print $2}') 
	echo "COMP2191-S22 and the associated IP are not available in the file."
	echo "Adding appropriate container and IP address... COMP2101-S22 and $IPaddress successfully added."
	
	fi

#This script checks if Apache is installed. If not, it install it.
lxc exec COMP2101-S22 -- dpkg --get-selections | grep -q apache
if [ $? -eq 0 ]; 
	then echo "Apache is already installed."
else
	echo "Apache is not installed. Installing now..."
	lxc exec COMP2101-S22 -- apt install apache2
	echo "Apache successfully installed."
fi

#This next script checks if Curl is installed on the system. If it is not, it will install it.
curl -s http://google.com 
if [ $? -eq 1 ]; 
then 
	echo "Curl command is not installed. Installing now."
	lxc exec COMP2101-S22 -- sudo apt install curl ;
	
else
	echo "Curl is already installed."
	
	fi
	
#This script attempts to retrieve web page via URL.

curl http://zonzorp.net && echo "Successfully retrieved Webpage!" ||
echo "Failed to retrieve Webpage!";

exit


