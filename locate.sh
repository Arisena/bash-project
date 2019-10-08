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

menu=( '1. Find Text within a File' '2. Info on User Accounts' '3. List Contents of a Directory' '4. Man Page of a Command' '5. Return to Main Menu' '6. Shutdown'  )

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
	#Locate Text in a File
	1)
		exist=0
		echo -e "Finding Text withing a file"
		echo -e "Please use full path to file"
		printf "What text would you like to find? "
		read text
		while [ $exist -eq 0 ]
		do
			printf "What file would you like to search? "
			read file
			if [[ -f $(bash -c "echo $file") ]]; then
				echo -e "File Found"
				exist=1
			else
				echo -e "Failed to find file"
			fi
		done
		echo -e "Opening search results"
		sleep 1
		grep --color=auto -rn $text $file | less
		echo -e $green"Output will be into search.txt for later use$white"
		grep --color=auto -rn $text $file > search.txt
		sleep 3
		clear
		;;
	#User Account Info
	2)
		;;
	#Contents of a Directory
	3)
		exists=0
		printf "Directory Contents\n"
		while [ $exists -eq 0 ]
		do
			printf "Full path may be required\n"
			printf "What directory would you like to view? "
			read dir
			if [[ -d $(bash -c "echo $dir") ]]; then
				echo -e $green"Directory Found"$white
				ls $dir
				exists=1
				printf "Press enter to continue"
				read
			else
				echo -e $red"Directory Not Found"$white
				sleep 4
			fi
		done
		clear
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
