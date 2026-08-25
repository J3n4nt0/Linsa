#!/usr/bin/bash
source .env

username="$username"
password="$password"
share=$1
source_local_dir=$2
default_dir="/home/$(whoami)"

exit_function(){
	echo -e "\e[91mExit\e[0m"
	sleep 0.2
        exit 1
}

# Find hosts ip address in arp table
get_host(){
	ip neigh | grep -E 'REACHABLE|STALE' | head -n5 | awk '{print $1}'
}

# Help

if [ -z $share ]; then
	echo -e "\nHELP COMMAND\n "
	echo -e "COMMAND : $(echo $0 | rev | cut -c -5 | rev) [arg: <samba-shared-directory>]"
	exit_function

elif [[ "$1" == "--search-host" || "$1" == "-s" ]];then
	echo "search mode enable"
	get_host
	exit 1
fi




##MAIN
echo -e '\e[1;96m\n=================================================\e[0m'
echo -e " \e[1;1;96m  LINUX AUTO SMBCLIENT TOOL BUILD BY J3nn!\e[0m"
echo -e '\e[1;1;1;96m=================================================\n\e[0m'

echo -e '\e[93m[**] Moving to the synchronized directory ...\n\e[0m' 
sleep 0.8

if [ -d "$source_local_dir" ];then 

	cd $source_local_dir
else
	if [ ! -d "$default_dir" ];then
		mkdir -p "$default_dir"
		cd $default_dir
	else
		cd $default_dir
	fi
fi

echo -e "\e[93m[**]CURRENT DIRECTORY\e[0m : $(pwd) \n"
echo -e "\e[93m[**]Searching for hosts ..\n\e[0m"
sleep 3

#create an array of hosts from ARP table
hosts=($(ip neigh | awk '{print $1}'))

if [ "${#hosts[@]}" == 0 ];then
	echo -e "\e[91mNo host has been found in the local network\e[0m"
	sleep 0.2
	exit_function
else
	echo  -e "\e[93m[**]HOST-IP-ADDRESS-FOUND-IN-THE-NETWORK :\e[0m \n"
	for host in "${hosts[@]}";do
	   	echo " + $host"
	done

	sleep 2
	for host in "${hosts[@]}";do
		echo -e "\n\e[93m[**] ATTEMPTING TO CONNECT TO :\e[0m $host/$1\n"
		smbclient //$host/$share -U $username%$password 
  	done
fi
