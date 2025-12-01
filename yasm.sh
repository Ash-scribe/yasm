#!/usr/bin/bash

path=~/.ssh/config

#Main loop
while getopts ":w" option; do
	case ${option} in
#Create new record in config
		w)
			read -p "Enter hostname: " host
			read -p "Enter IP address: " ip
			read -p "Enter ssh key algorithm: " key
			read -p "Enter username: " user
			echo -e "\nHost $host" >> $path
			echo -e "\tHostname $ip" >> $path
			echo -e "\tHostKeyAlgorithms +$key" >> $path
			echo -e "\tUser $user" >> $path
	esac
done
