#!/bin/bash
: <<'Script_Title'
 __  __           _                _     
|  \/  | __ _ ___| |_ ___ _ __ ___| |__  
| |\/| |/ _` / __| __/ _ \ '__/ __| '_ \ 
| |  | | (_| \__ \ ||  __/ | _\__ \ | | |
|_|  |_|\__,_|___/\__\___|_|(_)___/_| |_|  
Script_Title

dialog --title "Master.sh" \
	--backtitle 'Version 6.9.37' \
	--msgbox 'Work in Progress, Proceed at your own risk' 7 25

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
echo -e $gray"Warning, some options need you to be an admin"
echo -e $gray"Please consult system administrator if something fails"
sleep 2

while [ -z "$go" ]
do

clear

menu=( '1. File Operations' '2. User Operations' '3. Locating Information' '4. Process Menu' '5. Fun Stuff' '6. Exit' '7. Shut down' )

echo -e $gray"Numbers Only"
echo -e "$gray-MainMenu-"
for element in "${menu[@]}"
do
	echo -e $gray":$yellow "$element
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
		./process.sh 2> /dev/null
		;;
	5)
		./fun.sh 2> /dev/null
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
		;;
esac
done
