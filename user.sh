#!/bin/bash

black='\e[30m'
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
magenta='\e[35m'
cyan='\e[36m'
gray='\e[37m'
white='\e[0m'

clear

while [ -z "$go" ]
do

menu=( '1. Create User' '2. Change User Group' '3. Create Group' '4. Delete User' '5. Change Password' '6. Return to Main Menu' '7. Shutdown'  )

echo "Numbers Only"

echo "--UserOperations--"
for element in "${menu[@]}"
do
	echo ": $element"
done
echo "------------------"

read -p "choice: " choice
lower=${choice,,}

case $lower in
	#Create User
	1)
		;;
	#Change User Group
	2)
		;;
	#Create Group
	3)
		;;
	#Delete User
	4)
		;;
	#Change Password
	5)
		;;
	6)
		exit
		;;
	7)
		shutdown
		;;
	*)
		echo "Invalid Input"
		sleep 4
		clear
		;;
esac
done
