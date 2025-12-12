#!/usr/bin/bash

path_config=~/.ssh/config

#Loop with options
while getopts ":w,f" option; do
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
		f) #Flush ssh key
			path_key=~/.ssh/known_hosts
			read -p "Enter hostname: " host
			ip=$(awk '/'$host'/ {getline; print}' $path_config | cut -d ' ' -f 2)
			ssh-keygen -f $path_key -R $ip 
			exit;;	
		\?) #Invalid option
			echo "Invalid option"
	esac
done

#List all hosts
grep -iw host $path_config | cut -d ' ' -f 2
read -p "Enter hostname: " host

timeout 5 ssh $host
if [[ $? != 0 ]]
then
	echo "Timeout"
	exit;
fi
exit;
