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
				echo -e $green"File Found"
				exist=1
			else
				echo -e $red"Failed to find file"
			fi
		done
		echo -e $white"Opening search results"
		sleep 1
		grep --color=auto -rn $text $file | less
		echo -e $green"Output will be into search.txt for later use$white"
		grep --color=auto -rn $text $file > search.txt
		sleep 3
		clear
		;;
	#User Account Info
	2)
		exists=0
		printf "User Account Info\n"
		while [ $exists -eq 0 ]
		do
			printf "What user would you like to look at? "
			read user
			if grep -q $user /etc/passwd
			then
				echo -e $green"User Found"
				exists=1
			else
				echo -e $red"User not Found"
			fi
		printf $white
		printf "\n"
		grep $user /etc/passwd --color=auto
		printf "\n"
		printf "Press Enter to Continue"
		read
		clear
		done
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
				ls --color --group-directories-first --classify $dir
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
		clear
		exists=0
		manpage=0
		menu2=( '1. View Available Pages' '2. Choose Page' )

		while [ $exists -eq 0 ]
		do
		echo -e $gray"--------ManViewer--------"
		for element in "${menu2[@]}"
		do
			echo -e "$gray:$yellow $element"
		done
		echo -e "$gray-------------------------$white"
		printf "Choice: "
		read choice
		lower=${choice,,}

		case $lower in
			1)
				man -k . | less
				clear
				;;
			2)
				printf "Command is case sensitive\n"
				printf "If no man page is loaded no page was found\n"
				sleep 1
				while [ $manpage = 0 ]
				do
					printf $white"What man page would you like to view? "
					read page
					if man $page; then
						manpage=1
					else
						echo -e $red"No Page Found"
					fi
				done
				printf "Press Enter to Continue"
				read
				exists=1
				clear
				;;
			*)
				printf $red"Invalid Option"
				sleep 2
				clear
				;;
		esac
		done
		;;
	5)
		exit
		;;
	6)
		shutdown
		;;
	*)
		echo -e $red"Invalid Input"$white
		sleep 2
		clear
		;;
esac

done
