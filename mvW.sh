#\bin\bash
#set -x

#Move the current window West 
#  normal monitors: toggle window size between 66% and 50% of the screen width
#  ultrawide monitors: toggle window size between 34% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

if $ULTRAWIDE
then
	#FINALWIDTH=$(($SCREENWIDTH - $SCREENWIDTHULTRA))
    #FINALWIDTH=$(($FINALWIDTH/2)) #this works less nicely
    FINALWIDTH=$SCREENWIDTHULTRALATERAL
else
	FINALWIDTH=$SCREENWIDTH050
fi

#Because it gets moved to the West, left space is 0+PANELLEFT
LEFTSPACE=$PANELLEFT

#Difference between window width and final window width
SCREENWIDTHDIFF=$(($WIDTH-$FINALWIDTH))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to West
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $PANELLEFT 0

#Resize and move window to the left
#  normal monitors: window width 66% by default. If already 66% make it 50% wide
#  ultrawide monitors: window width SCREENWIDTHULTRA by default. If already default make it 33% wide
if [ $X -lt $HEIGHTDIFFCONST ] && [ $Y -lt $HEIGHTDIFFCONST ] && [ $SCREENWIDTHDIFF -lt $HEIGHTDIFFCONST ]
then
	if $ULTRAWIDE
	then
		FINALWIDTH=$SCREENWIDTH033
		echo "WIDTH is close to default SCREENWIDTH. Make it 33% then move to the left"
	else
		FINALWIDTH=$SCREENWIDTH066
		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left"
	fi
    xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0 0
fi

CHECK=1
while [ $CHECK -lt 10 ]
do
	eval `xdotool getwindowgeometry --shell $WINDOW`
	if [ $X -gt 100 ]
	then
		echo "X=$X not right. Subtract CHECK*5px=$(($CHECK*4)) to SCREENHEIGHT "
    	xdotool windowsize $WINDOW $FINALWIDTH $(($SCREENHEIGHT-$CHECK*4)) #--sync can make it hang
    	xdotool windowmove $WINDOW $(($PANELLEFT+$LEFTSPACE)) 0 0
    	CHECK=$(($CHECK+1))
    else 
    	CHECK=10
	fi
done

echo "SCREENWIDTH=$SCREENWIDTH"
echo "SCREENWIDTHULTRA=$SCREENWIDTHULTRA"
echo "FINALWIDTH=$FINALWIDTH"
echo "LEFTSPACE=$LEFTSPACE"
