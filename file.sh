#!/bin/bash

clear

while [ -z "$go" ]
do

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
		echo "File Creation"
		echo "Please use full path for a different directory"
		read -p $'What file do you want to create? ' file
		touch $file
		if [[ -f $(bash -c "echo $file") ]]; then
			echo "File Created"
			ls $file
			sleep 4
			clear
		else
			echo "Failed to create file"
			sleep 4
			clear
		fi
		;;
	#File Deletion
	2)
		echo "File Deletion"
		echo "Please use full path"
		echo "Directories not supported"
		read -p $'What file do you want to delete? ' file
		if [[ -f $(bash -c "echo $file") ]]; then
			rm $file
			echo "File Deleted"
			sleep 4
			clear
		else
			echo "Failed to delete file"
			sleep 4
			clear
		fi
		;;
	#Directory Creation
	3)
		echo "Create Directory"
		echo "Please use full path"
		read -p $'What directory would you like to create? ' dir
		mkdir $dir
		if [[ -f $(bash -c "echo $file") ]]; then
			echo "Directory Created"
			sleep 4
			clear
		else
			echo "Failed to create directory"
			sleep 4
			clear
		fi
		;;
	#Delete Directory
	4)
		;;
	#Create Symlink
	5)
		;;
	#Change Ownership
	6)
		;;
	#Change Permissions
	7)
		;;
	#Modify Test
	8)
		;;
	9)
		exit
		;;
	10)
		shutdown
		;;
esac
done
