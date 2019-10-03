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

menu=( '1. Find Text within a File' '2. Info on User Accounts' '3. List Contents of a Directory' '4. Man Page of a Command' '6. Return to Main Menu' '7. Shutdown'  )

echo -e $gray"Numbers Only"

echo -e "$gray-LocatingInfo-"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element"
done
echo -e "$gray--------------$white"

printf "Choice: "
read choice
lower=${choice,,}

case $lower in
	#Text Location
	1)
		;;
	#User Account Info
	2)
		;;
	#Contents of a Directory
	3)
		;;
	#Man Pages
	4)
		;;
	5)
		exit
		;;
	6)
		shutdown
		;;
	*)
		echo -e $red"Invalid Input"$white
		;;
esac

done
