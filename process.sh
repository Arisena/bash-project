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
		printf "Process View\n"
		printf "Starting 'ps'"
		sleep 1
		ps -e > ps_output.txt
		ps -e | less
		printf "Output has also been saved to ps_output.txt\n"
		printf "Press enter to continue"
		clear
		;;
	#Kill a Process
	2)
		printf "Process Kill Mode\n"
		printf "Listing available processes\n"
		ps -u
		printf "To kill a process look at the PID and input that\n"
		printf "What process would you like to kill? "
		read $pid
		kill $pid 2> /dev/tty
		;;
	#top
	3)
		printf "Opening Top"
		sleep 1
		top
		printf "Restarting Script"
		sleep 1
		clear
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
	*)
		;;
esac
done
