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

while [ -z $go ]
do

menu=( '1. View all Processes' '2. Kill a Process' '3. Top' '4. Change Process Priority' '5. Return to Main Menu' '6. Shutdown' )

echo -e $gray"Numbers Only"

echo -e "$gray-FileOperations-"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element"
done
echo -e "$gray----------------$white"

printf "Choice: "
read choice
lower=${choice,,}

case $lower in
	#Process View
	1)
		printf "Starting 'ps'"
		sleep 1
		ps -e > ps_output.txt
		ps -e | less
		printf "Output has also been saved to ps_output.txt\n"
		printf "Press enter to continue"
		;;
	#Kill a Process
	2)
		;;
	#top
	3)
		;;
	#Change Priority
	4)
		;;
	5)
		exit 0
		;;
	6)
		shutdown
		;;
esac
done
