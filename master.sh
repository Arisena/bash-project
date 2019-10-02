#!/bin/bash

while [ -z "$go" ]
do

clear

menu=( '1. File Operations' '2. User Operations' '3. Locating Information' '4. Fun Stuff' '5. Process Menu' '6. Exit' '7. Shut down' )

echo "Numbers Only"
echo "-MainMenu-"
for element in "${menu[@]}"
do
	echo ": $element"
done
echo "----------"

read -p "Choice: " choice
lower=${choice,,}

case $lower in
	1)
		./file.sh
		;;
	2)
		;;
	3)
		;;
	4)
		;;
	5)
		;;
	6)
		exit
		;;
	7)
		shutdown
		;;
	*)
		echo "Invalid Input"
		;;
esac
done
