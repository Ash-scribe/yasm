#!/usr/bin/bash

#Main loop
while getopts ":w" option; do
	case ${option} in
#Create new record in config
		w)
			read -p "Enter hostname: " host
			read -p "Enter IP address: " ip
			read -p "Enter ssh key algorithm: " key
			read -p "Enter username: " user
			echo -e "Host $host" >> ~/.ssh/config
			echo -e "\tHostname $ip" >> ~/.ssh/config
			echo -e "\tHostKeyAlgorithms +$key" >> ~/.ssh/config
			echo -e "\tUser $user" >> ~/.ssh/config
	esac
done
