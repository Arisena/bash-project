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
