#!/usr/bin/env bash


################################################################################
# Author :	BigRush
#
# License :  GPLv3
#
# Description :  Shows internal and external IP address
#
# Version :  1.0.0
################################################################################

Internal_IP () {
	int_ip=$(ip route show |awk '{print $3,$9}' |sed '1d')
	if [[ -z ${int_ip[*]} ]]; then
		echo "Could not retrieve internal IP..."
		exit 1
	else
		echo "Your internal IP is: $int_ip"
		exit 0
	fi
}	
	
External_IP () {	
	echo "Checking internet connection..."
	ping -c 3 ipinfo.io &> /dev/null
	if [[ $? -eq 0 ]]; then
		ext_ip=$(curl -s https://ipinfo.io/ip)
		echo "Your external IP is: $ext_ip"
		exit 0
	else
		echo "Unable to connect to the interet, can't determine external IP"
		exit 1
	fi
}

Menu () {
	local IFS=","
	OPTIONS=("External IP","Internal IP","Exit")
	PS3="Please select an option: "
	select opt in ${OPTIONS[*]}; do
		case $opt in
			"External IP")
				External_IP
				;;

			"Internal IP")
				Internal_IP
                       		;;
	
			"Exit")
				echo "Exiting - Have a nice day!"
				exit 0
				;;
	
			*)
				echo "Invalid option"
				;;
		esac
	done
}
Menu
