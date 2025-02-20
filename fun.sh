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

trap ctrl_z sigtstp
trap ctrl_c sigint

function ctrl_z() {
	echo
	echo "ERROR: SIGTSTP(ctrl_z) NOT SUPPORTED"
}
function ctrl_c() {
	echo
	echo "SIGINT RECEIVED"
	echo "EXITING PROGRAM"
	exit 1
}

clear

printf $magenta"Warning : Some programs may not be installed on your current system\n"
printf "Required Programs are as follows:\n"
printf "fortune-mod, sl, cmatrix, cowsay, figlet, and cln\n"
printf "Please contact your system administrator if some of these aren't installed\n"
sleep 4
clear

while [ -z $go ]
do

menu=( '1. Fortune' '2. sl' '3. cmatrix' '4. Ghostbusters' '5. figlet banner' '6. pi' '7. Return to Main Menu' '8. Shutdown' )

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
	#Fortune
	1)
		fortune -ac
		printf '%s%s%s%s' "$(tput setaf 2)" "$(tput blink)" "Press enter to continue" "$(tput sgr0)"
		read
		clear
		;;
	#sl
	2)
		sl
		clear
		;;
	#cmatrix
	3)
		cmatrix
		clear
		;;
	#cowsay Ghostbusters
	4)
		cowsay -f ghostbusters Who you Gonna Call
		echo
		echo
		printf '%s%s%s%s' "$(tput setaf 2)" "$(tput blink)" "Press enter to continue" "$(tput sgr0)"
		read
		clear
		;;
	#figlet
	5)
		printf "What would you like the text to be? "
		read text
		figlet $text
		printf "Output printed to 'figlet_output.txt'\n"
		figlet $text >> figlet_output.txt
		printf '%s%s%s%s' "$(tput setaf 2)" "$(tput blink)" "Press enter to continue" "$(tput sgr0)"
		read
		clear
		;;
	#pi
	6)
		printf "Pi Calculator\n"
		printf "Warning higher numbers will take longer to calculate\n"
		printf "How many numbers would you like to have displayed? "
		read number
		pi $number
		printf "Output sent to pi_output.txt\n"
		pi $number > pi_output.txt
		printf '%s%s%s%s' "$(tput setaf 2)" "$(tput blink)" "Press enter to continue" "$(tput sgr0)"
		read
		clear
		;;
	7)
		exit 0
		;;
	8)
		shutdown
		;;
	*)
		echo -e $red"Invalid Input"$white
		sleep 2
		clear
		;;
esac
done
