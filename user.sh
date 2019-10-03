#!/bin/bash

[ -z $CALLED_FROM_START_APP ] && { echo "Not called from master.sh"; exit 42; }

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
		exist=0
		echo "User Creation Mode"
		read -p $'What would you like the username to be? ' user
		read -p $'What would you like the comment to be? ' com
		while [ $exist -eq 0 ]
		do
			read -p $'What would you like the group to be? ' group
			if grep -q $group /etc/group
			then
				echo "Group exists"
				exist=1
			else
				echo "Group not found"
			fi
		done
		useradd -c $com -g $group $user
		grep $user /etc/passwd
		;;
	#Change User Group
	2)
		exist1=0
		exist2=0
		echo "User Group Change Mode"
		while [ $exist1 -eq 0 ]
		do
			read -p $'What user would you like to edit? ' user
			if grep -q $user /etc/passwd
			then
				echo "User exists"
				exist1=1
			else
				echo "User not found"
			fi
		done
		while [ $exist2 -eq 0 ]
		do
			read -p $'What group would you like to change them too? ' group
			if greo -q $group /etc/group
			then
				echo "Groups exists"
				exist2=1
			else
				echo "Group not found"
			fi
		done
		usermod -a -G $group $user
		echo "Group added to user"
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
		exit 0
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
