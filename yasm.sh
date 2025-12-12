#!/usr/bin/bash

path=~/.ssh/config

grep -iw host $path | cut -d ' ' -f 2
read -p "Enter hostname: " host
ssh $host
exit
# Loop with options
while getopts ":w" option; do
	case ${option} in
		w) #Create new record in config
			read -p "Enter hostname: " host
			read -p "Enter IP address: " ip
			read -p "Enter ssh key algorithm: " key
			read -p "Enter username: " user
			echo -e "\nHost $host" >> $path
			echo -e "\tHostname $ip" >> $path
			if [ -n "$key" ] 
			then
				echo -e "\tHostKeyAlgorithms +$key" >> $path
			fi
			echo -e "\tUser $user" >> $path
			exit;;
		\?) #Invalid option
			echo "Invalid option"
	esac
done
