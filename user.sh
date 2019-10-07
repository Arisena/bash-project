#!/bin/bash

[ -z $CALLED_FROM_START_APP ] && { echo -e "Not called from master.sh"; exit 42; }

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

echo -e $gray"Numbers Only"

echo -e "$gray--UserOperations--"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element"
done
echo -e "$gray------------------$white"

printf "Choice: "
read choice
lower=${choice,,}

case $lower in
	#Create User
	1)
		exist=0
		echo -e "User Creation Mode"
		printf "What would you like the username to be? "
		read user
		printf "What would you like the comment to be? "
		read com
		while [ $exist -eq 0 ]
		do
			printf "What would you like the group to be? "
			read group
			if grep -qw $group /etc/group
			then
				echo -e $green"Group exists"
				exist=1
			else
				echo -e $red"Group not found"
			fi
		done
		useradd -c "$com" -g $group $user
		if grep $user /etc/passwd
		then
			echo -e $green"Creation Successful"
		else
			echo -e $red"Creation Failed"
		fi
		;;
	#Change User Group
	2)
		exist1=0
		exist2=0
		echo -e "User Group Change Mode"
		while [ $exist1 -eq 0 ]
		do
			printf "What user would you like to edit"
			read user
			if grep -qw $user /etc/passwd
			then
				echo -e $green"User exists"
				exist1=1
			else
				echo -e $red"User not found"
			fi
		done
		while [ $exist2 -eq 0 ]
		do
			printf "What group would you like to put them in"
			read group
			if greo -q $group /etc/group
			then
				echo -e $green"Groups exists"
				exist2=1
			else
				echo -e $red"Group not found"
			fi
		done
		usermod -a -G $group $user
		echo -e "Attempting to add group added to user"
		grep $group /etc/group
		echo -e "If user was not added access was denied"
		;;
	#Create Group
	3)
		echo -e "Group Creation"
		printf "What group would you like to create? "
		read group
		groupadd $group
		if grep -qw $group /etc/group
		then
			echo -e $green"Creation Successful"
		else
			echo -e $red"Creation Failed"
		fi
		sleep 4
		clear
		;;
	#Delete User
	4)
		exists=0
		echo -e "User Deletion"
		while [ $exists -eq 0 ]
		do
			printf "What user would you like to delete? "
			read user
			if grep -qw $user /etc/passwd
			then
				echo -e $green"User found, attempting delete"
				userdel $user
				exists=1
			else
				echo -e $red"User no found"
			fi
		done
		if grep -qw $user /etc/passwd
		then
			echo -e $red"Deletion Failed"
		else
			echo -e $green"Deletion Successful"
		fi
		sleep 4
		clear
		;;
	#Change Password
	5)
		exists=0
		echo -e "Password Change"
		echo -e "Note, you must be an admin to change other people password"
		while [ $exists -eq 0 ]
		do
			printf "What user are we changing the passwd for? "
			read user
			if grep -qw $user /etc/passwd
			then
				echo -e $green"User Found"
				exists=1
			else
				echo -e $red"User not found"
			fi
		done
		echo -e "Staring Command"
		passwd $user &> /dev/tty
		;;
	6)
		exit 0
		;;
	7)
		shutdown
		;;
	*)
		echo -e $red"Invalid Input"
		sleep 4
		clear
		;;
esac
done
