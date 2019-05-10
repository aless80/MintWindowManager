#\bin\bash
set -x

#Move the current window to the center
#  ultrawide monitors: make window size 34% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

FINALWIDTH=$SCREENWIDTH033
#Difference between window width and 34% screen width
SCREENWIDTHDIFF=$(($WIDTH-$SCREENWIDTH033))
XPOSITIONDIFF=$(($X-$PANELLEFT-$SCREENWIDTH033))

#Move to Center
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH033)) 0

#Resize and move window to the center
#  ultrawide monitors: window width 34% by default. If already 34% make it 50% wide
if [ $XPOSITIONDIFF -lt 100 ] && [ $HEIGHT -gt $(($SCREENHEIGHT-200)) ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
	FINALWIDTH=$(($SCREENWIDTH*4/10))
	echo "WIDTH is close to SCREENWIDTH*0.34. Make it 40% then move to the left"
    xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH033)) 0
fi
