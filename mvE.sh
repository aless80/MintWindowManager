#\bin\bash
#set -x

#Move the current window East
#  normal monitors: toggle window size between 34% and 50% of the screen width
#  ultrawide monitors: toggle window size between 34% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

if $ULTRAWIDE
then
	FINALWIDTH=$(($SCREENWIDTH-$SCREENWIDTHULTRA))
	FINALWIDTH=$(($FINALWIDTH/2))
	XPOSITIONDIFF=$(($X-$PANELLEFT-$FINALWIDTH))
else
	FINALWIDTH=$SCREENWIDTH050
    LEFTSPACE=$SCREENWIDTH033*2
	XPOSITIONDIFF=$X
fi

#Because it gets moved to the East, left space is SCREENWIDTH minus the actual width
LEFTSPACE=$(($SCREENWIDTH-$FINALWIDTH))

#Difference between window width and final window width
SCREENWIDTHDIFF=$(($WIDTH-$FINALWIDTH))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to East
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0

#Resize and move window to the right
#  normal monitors: window width 50% by default. If already 50% make it 34% wide
#  ultrawide monitors: window width SCREENWIDTHULTRA by default. If already default make it 33% wide
if [ $XPOSITIONDIFF -gt 100 ] && [ $HEIGHT -gt $(($SCREENHEIGHT-200)) ] && [ $Y -lt $HEIGHTDIFFCONST ] && [ $SCREENWIDTHDIFF -lt $HEIGHTDIFFCONST ]
then
#	if $ULTRAWIDE
#	then
		FINALWIDTH=$SCREENWIDTH033
		echo "WIDTH is close to default SCREENWIDTH. Make it 33% then move to the right"
#	else
#		FINALWIDTH=$SCREENWIDTH033
#		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 34% then move to the right"
#	fi    
    xdotool windowsize $WINDOW $(($FINALWIDTH)) $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0
fi

echo "SCREENWIDTH=$SCREENWIDTH"
echo "SCREENWIDTHULTRA=$SCREENWIDTHULTRA"
echo "FINALWIDTH=$FINALWIDTH"
echo "LEFTSPACE=$LEFTSPACE"
