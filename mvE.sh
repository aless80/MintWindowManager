#\bin\bash
#set -x

#Move the current window East
#  wide monitors: toggle window size between 34% and 50% of the screen width
#  ultrawide monitors: toggle window size between 34% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

if $ULTRAWIDE
then
	FINALWIDTH=$SCREENWIDTH033
	XPOSITIONDIFF=$(($X-$PANELLEFT-$SCREENWIDTH033))
else
	FINALWIDTH=$SCREENWIDTH050
	XPOSITIONDIFF=$X
fi

#Difference between window width and final window width
SCREENWIDTHDIFF=$(($WIDTH-$FINALWIDTH))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to East
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH033*2)) 0

#Resize and move window to the right
#  wide monitors: window width 50% by default. If already 50% make it 34% wide
#  ultrawide monitors: window width 34% by default. If already 34% make it 50% wide
if [ $XPOSITIONDIFF -gt 100 ] && [ $HEIGHT -gt $(($SCREENHEIGHT-200)) ] && [ $Y -lt 100 ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
	if $ULTRAWIDE
	then
		FINALWIDTH=$SCREENWIDTH050
		echo "WIDTH is close to SCREENWIDTH*0.34. Make it 50% then move to the right"
	else
		FINALWIDTH=$SCREENWIDTH033
		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 34% then move to the right"
	fi    
    xdotool windowsize $WINDOW $(($FINALWIDTH)) $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH033*2)) 0
fi
