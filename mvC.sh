#\bin\bash
#set -x

#Move the current window to the center
#  ultrawide monitors: make window size 48% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

FINALWIDTH=$SCREENWIDTHULTRA
LEFTSPACE=$SCREENWIDTH025

#Difference between window width and 50% screen width
XPOSITIONDIFF=$(($X-$PANELLEFT-$LEFTSPACE))
SCREENWIDTHDIFF=$(($WIDTH-$FINALWIDTH))

#Move to Center
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0

#Resize and move window to the center
#  ultrawide monitors: window width 48% by default. If already at the default width, make it 33% wide
if [ $XPOSITIONDIFF -lt $HEIGHTDIFFCONST ] && [ $HEIGHT -gt $(($SCREENHEIGHT-200)) ] && [ $SCREENWIDTHDIFF -lt $HEIGHTDIFFCONST ]
then
	FINALWIDTH=$SCREENWIDTH033
    LEFTSPACE=$SCREENWIDTH033
	echo "WIDTH is close to default SCREENWIDTH. Make it 33%"
    xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0
fi

echo "SCREENWIDTH=$SCREENWIDTH"
echo "SCREENWIDTHULTRA=$SCREENWIDTHULTRA"
echo "FINALWIDTH=$FINALWIDTH"
echo "LEFTSPACE=$LEFTSPACE"
