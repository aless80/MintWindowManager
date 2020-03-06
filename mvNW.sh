#\bin\bash
#set -x

#Move the current window North West
#  normal monitors: toggle window size between 34% and 50% of the screen width
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

#Resize and move window to the North West
#  normal monitors: window width 50% by default. If already 50% make it 66% wide
#  ultrawide monitors: window width 34% by default. If already 34% make it 50% wide
xdotool windowsize $WINDOW $FINALWIDTH y #$SCREENHEIGHT050
xdotool windowmove $WINDOW $PANELLEFT 0

#Resize and move window to the left
#Make window 50% of the screen width by default. If already 50% of the width, make it 66%
if [ $X -lt $HEIGHTDIFFCONST ] && [ $Y -lt $HEIGHTDIFFCONST ] && [ $SCREENWIDTHDIFF -lt $HEIGHTDIFFCONST ]
then
	if $ULTRAWIDE
	then
		echo "WIDTH is close to SCREENWIDTH*0.33. Make it 50% then move to the left part of the screen"
		FINALWIDTH=$SCREENWIDTH050
		xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT050 #--sync can make it hang
		xdotool windowmove $WINDOW $PANELLEFT 0
	else
    	echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left part of the screen"
    	FINALWIDTH=$SCREENWIDTH066
    	xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT050 #--sync can make it hang
    	xdotool windowmove $WINDOW $PANELLEFT 0
    fi
fi
