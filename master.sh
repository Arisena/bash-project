#!/bin/bash

export CALLED_FROM_START_APP=yes

black='\e[30m'
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
magenta='\e[35m'
cyan='\e[36m'
gray='\e[37m'
white='\e[0m'

echo -e $gray"warning, some options need you to be an admin"
echo -e $gray"please consult system administrator if something fails"
echo -e $gray"waranty voided upon code modification"
sleep 4

while [ -z "$go" ]
do

clear

menu=( '1. File Operations' '2. User Operations' '3. Locating Information' '4. Fun Stuff' '5. Process Menu' '6. Exit' '7. Shut down' )

echo -e $gray"Numbers Only"
echo -e "$gray-MainMenu-"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element $white"
done
echo -e "$gray----------"

read -p $'\e[0mChoice: ' choice
lower=${choice,,}

case $lower in
	1)
		./file.sh 2> /dev/null
		;;
	2)
		./user.sh 2> /dev/null
		;;
	3)
		./locate.sh 2> /dev/null
		;;
	4)
		./fun.sh 2> /dev/null
		;;
	5)
		./process.sh 2> /dev/null
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
		;;
esac
done
