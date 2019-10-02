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

menu=( '1. Create File' '2. Delete File' '3. Create Directory' '4. Delete Directory' '5. Create SymLink' '6. Change Ownership of file' '7. Change Permissions of file' '8. Modify Text' '9. Return to Main Menu' '10. Shutdown' )

echo -e $gray"Numbers Only"

echo -e "$gray-FileOperations-"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element"
done
echo -e "$gray----------------"

read -p $'\e[0mChoice: ' choice
lower=${choice,,}

case $lower in
	#File Creation
	1)
		echo "File Creation"
		echo "Please use full path for a different directory"
		read -p $'What file do you want to create? ' file
		touch $file
		if [[ -f $(bash -c "echo $file") ]]; then
			echo -e $green"File Created"$white
			ls $file
			sleep 4
			clear
		else
			echo -e $red"Failed to create file"$white
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
			echo -e $green"File Deleted"$white
			sleep 4
			clear
		else
			echo -e $red"Failed to delete file"$white
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
		if [[ -d $(bash -c "echo $dir") ]]; then
			echo -e $green"Directory Created"$white
			sleep 4
			clear
		else
			echo -e $red"Failed to create directory"$white
			sleep 4
			clear
		fi
		;;
	#Delete Directory
	4)
		echo "Directory Removal"
		echo "Please us full path"
		echo "Please not directory must be empty"
		read -p $'What directory would you like to delete? ' dir
		if [[ -d $(bash -c "echo $dir") ]]; then
			rmdir $dir
			echo -e $green"Directory Deleted"$white
			sleep 4
			clear
		else
			echo -e $red"Failed to remove directory"$white
			sleep 4
			clear
		fi
		;;
	#Create Symlink
	5)
		exist=0
		echo "Symlink Creation"
		echo "Full path is needed here"
		while [ $exist -eq 0 ]
		do
		read -p $'What file are we symlinking today? ' file
		if [[ -f $(bash -c "echo $file") ]]; then
			exist=1
			echo -e $green"File exists"$white
		elif [[ -d $(bash -c "echo $file") ]]; then
			exist=1
			echo -e $green"Directory exists"$white
		else
			echo -e $red"File does not exist"$white
		fi
		done
		read -p $'Where would you like the symlink to be? ' link
		ln -s $file $link
		if [[ -e $(bash -c "echo $link") ]]; then
			echo $green"Creation Successful"$white
			ls $link
			sleep 4
			clear
		else
			echo -e $red"Creation failed"$white
		fi
		;;
	#Change Ownership
	6)
		exists1=0
		exists2=0
		exists3=0
		echo "Ownership Change"
		echo "Please use full path to file"
		while [ $exists1 -eq 0 ]
		do
			read -p $'Who should own this file? ' user
			if grep -q $user /etc/passwd
			then
				echo -e $green"User exists"$white
				exists1=1
			else
				echo -e $red"No user by that name"$white
			fi
		done
		while [ $exists2 -eq 0 ]
		do
			read -p $'What should be the default group? ' group
			if grep -q $group /etc/group
			then
				echo -e $green"Group exists"$white
				exists2=1
			else
				echo -e $green"No group by that name"$white
			fi
		done
		while [ $exists3 -eq 0 ]
		do
			read -p $'What file are we changing the ownership of? ' file
		if [[ -f $(bash -c "echo $file") ]]; then
			echo -e $green"File exists"$white
			exists3=1
		else
			echo -e $red"No file found"$white
		fi
		done
		chown $user:$group $file
		ls -l $file
		sleep 4
		clear
		;;
	#Change Permissions
	7)
		exists=0
		echo "File permissions changes"
		echo "Please use full path"
		read -p $'What do you want the file permissions to be? ' perm
		while [ $exists -eq 0 ]
		do
			read -p $'What file do you want to change? ' file
			if [[ -f $(bash -c "echo $file") ]]; then
				echo -e $green"File exists"$white
				exists=1
			else
				echo -e $red"No file found"$white
			fi
		done
		chmod $perm $file
		ls -l $file
		sleep 4
		clear
		;;
	#Modify file
	8)
		exists1=0
		echo "File editing"
		echo "Please use full path"
		while [ $exists1 -eq 0 ]
		do
			menu=( 'vi' 'vim' 'nano' )
			echo -e "$gray----"
			for element in "${menu[@]}"
			do
				echo -e "$gray:$yellow $element"
			done
			echo -e "$gray----"
			read -p $'\e[0mWhat text editor would you like to use? ' editor
			lower2=${editor,,}
			case $lower2 in
				vi|vim|nano)
					echo -e $green"Editor Exists"$white
					exists1=1
					;;
				*)
					echo -e $red"No editor found, please use the list"$white
			esac
		done
		read -p $'\e[0mWhat file would you like to edit? ' file
		$editor $file
		;;
	9)
		exit
		;;
	10)
		shutdown
		;;
	*)
		echo -e $red"Invalid Input"$white
		;;
esac
done
