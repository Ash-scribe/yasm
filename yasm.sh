#!/usr/bin/bash

path_config=~/.ssh/config

get_host_names(){
	grep -iw host $path_config | cut -d ' ' -f 2
	read -p "Enter hostname: " host
}

get_ip(){
	path_key=~/.ssh/known_hosts
	ip=$(awk '/\<'$host'\>/ {getline; print}' $path_config | cut -d ' ' -f 2)
}

#Loop with options
while getopts ":w,f,t,h" option; do
	case ${option} in
		w) #Create new record in config
			read -p "Enter hostname: " host
			read -p "Enter IP address: " ip
			read -p "Enter ssh key algorithm: " key
			read -p "Enter username: " user
			echo -e "\nHost $host" >> $path_config
			echo -e "\tHostname $ip" >> $path_config
			if [ -n "$key" ] 
			then
				echo -e "\tHostKeyAlgorithms +$key" >> $path_config
			fi
			echo -e "\tUser $user" >> $path_config
			exit;;
		t) #Use telnet
			get_host_names
			get_ip
			telnet $ip	
			exit;;
		f) #Flush ssh key
			read -p "Enter hostname: " host
			get_ip
			ssh-keygen -f $path_key -R $ip 
			exit;;	
		h)	echo "Options: -w to Create new record in config. -t to use telnet instead of ssh. -f to flush ssh key"
			exit;;
		\?) #Invalid option
			echo "Invalid option"
	esac
done

#Connect using ssh
get_host_names
ssh -o ConnectTimeout=3 "$host"
#if [[ $? -ne 0 ]]; then
#	echo "Timeout"
#	exit 1
#fi
exit
