#\bin\bash
#set -x

#Move the current window South West toggling its size between 66% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

#Difference between window width and 50% screen width
SCREENWIDTHDIFF=$(($WIDTH-$SCREENWIDTH050))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to South West, for now 50% 50% or keep width smaller than 50%
if [ $HEIGHT -lt $((SCREENHEIGHT050-100)) ] 
then
	echo "HEIGHT is lower than SCREENHEIGHT*0.5. Move it to the bottom-left part of the screen with original width"
	xdotool windowsize $WINDOW $SCREENWIDTH050 y
	xdotool windowmove $WINDOW $PANELLEFT $(($SCREENHEIGHT-$HEIGHT))
else
	echo "HEIGHT is greater than SCREENHEIGHT*0.5. Move it to the bottom-left part of the screen with 50% width"
	xdotool windowsize $WINDOW $SCREENWIDTH050 $SCREENHEIGHT050
	xdotool windowmove $WINDOW $PANELLEFT $SCREENHEIGHT050
fi

#Resize and move window to the left
#Made window 50% of the screen width by default. If already 50% of the width, make it 66%
if [ $X -lt 100 ] && [ $Y -gt $((SCREENHEIGHT050-100)) ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
    echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left part of the screen"
    xdotool windowsize $WINDOW $SCREENWIDTH066 $SCREENHEIGHT050 #--sync can make it hang
    xdotool windowmove $WINDOW $PANELLEFT $SCREENHEIGHT050
fi
