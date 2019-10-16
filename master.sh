#!/bin/bash

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

center()
{
    local terminal_width=$(tput cols)     # query the Terminfo database: number of columns
    local text="${1:?}"                   # text to center
    local glyph="${2:-=}"                 # glyph to compose the border
    local padding="${3:-2}"               # spacing around the text

    local text_width=${#text}             

    local border_width=$(( (terminal_width - (padding * 2) - text_width) / 2 ))

    local border=                         # shape of the border

    # create the border (left side or right side)
    for ((i=0; i<border_width; i++))
    do
        border+="${glyph}"
    done

    # a side of the border may be longer (e.g. the right border)
    if (( ( terminal_width - ( padding * 2 ) - text_width ) % 2 == 0 ))
    then
        # the left and right borders have the same width
        local left_border=$border
        local right_border=$left_border
    else
        # the right border has one more character than the left border
        # the text is aligned leftmost
        local left_border=$border
        local right_border="${border}${glyph}"
    fi

    # space between the text and borders
    local spacing=

    for ((i=0; i<$padding; i++))
    do
        spacing+=" "
    done

    # displays the text in the center of the screen, surrounded by borders.
    printf "${left_border}${spacing}${text}${spacing}${right_border}\n"
}

clear
center $gray"Warning, some options need you to be an admin"$white " "
center $gray"Please consult system administrator if something fails"$white " "
sleep 3

while [ -z "$go" ]
do

clear

menu=( '1. File Operations' '2. User Operations' '3. Locating Information' '4. Process Menu' '5. Fun Stuff' '6. Exit' '7. Shut down' )

echo -e $gray"Numbers Only"
echo -e "$gray-MainMenu-"
for element in "${menu[@]}"
do
	echo -e "$gray:$yellow $element $white"
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
		echo $red"Invalid Input"
		sleep 4
		;;
esac
done
