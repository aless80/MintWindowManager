#\bin\bash
#set -x

#Move the current window North East
#  wide monitors: toggle window size between 34% and 50% of the screen width
#  ultrawide monitors: toggle window size between 34% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

if $ULTRAWIDE
then
	FINALWIDTH=$SCREENWIDTH033
else
	FINALWIDTH=$SCREENWIDTH050
fi

#Difference between window width and final window width
SCREENWIDTHDIFF=$(($WIDTH-$FINALWIDTH))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to North East
if [ $HEIGHT -lt $((SCREENHEIGHT050-100)) ] 
then
	echo "HEIGHT is lower than SCREENHEIGHT*0.5. Move it to the top-right part of the screen with original width"
	xdotool windowsize $WINDOW $FINALWIDTH y
	xdotool windowmove $WINDOW $(($SCREENWIDTH+$PANELLEFT-$FINALWIDTH)) 0
else
	echo "HEIGHT is greater than SCREENHEIGHT*0.5. Move it to the top-right part of the screen with 50% width"
	xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT050
	xdotool windowmove $WINDOW $(($SCREENWIDTH+$PANELLEFT-$FINALWIDTH)) 0
fi

#Resize and move window to the right
#  wide monitors: window width 50% by default. If already 50% make it 34% wide
#  ultrawide monitors: window width 34% by default. If already 34% make it 50% wide
if [ $X -gt 100 ] && [ $Y -lt 100 ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
	if $ULTRAWIDE
	then
		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 50% then move to the right part of the screen"
		FINALWIDTH=$SCREENWIDTH050
		xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT050 #--sync can make it hang
		xdotool windowmove $WINDOW $(($SCREENWIDTH+$PANELLEFT-$FINALWIDTH)) 0
	else
		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 34% then move to the right part of the screen"
		FINALWIDTH=$SCREENWIDTH033
		xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT050 #--sync can make it hang
		xdotool windowmove $WINDOW $(($SCREENWIDTH+$PANELLEFT-$FINALWIDTH)) 0
   fi
fi
