#!/bin/bash

while [ -z "$go" ]
do

clear

menu=( '1. Create File' '2. Delete File' '3. Create Directory' '4. Delete Directory' '5. Create SymLink' '6. Change Ownership of file' '7. Change Permissions of file' '8. Modify Text' '9. Return to main menu' '10. Shutdown' )

echo "Numbers Only"
echo "-FileOperations-"
for element in "${menu[@]}"
do
	echo ": $element"
done
echo "----------------"

read -p "Choice: " choice
lower=${choice,,}

case $lower in
	#File Creation
	1)
		back=0
		echo "Please use full path for a different directory"
		while [ $back -eq 0 ]
		do
		read -p $'What file do you want to create? ' file
		touch $file
		if [[ -f $(bash -c "echo $file") ]]; then
			echo "File Created"
			back=1
		else
			echo "Failed"
		fi
		done
		;;
	#File Deletion
	2)
		;;
	3)
		;;
	4)
		;;
	5)
		;;
	6)
		;;
	7)
		;;
	8)
		;;
	9)
		./master.sh
		;;
	10)
		shutdown
		;;
esac
done
