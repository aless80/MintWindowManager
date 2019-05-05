#\bin\bash
#set -x

#Move the current window West 
#  wide monitors: toggle window size between 66% and 50% of the screen width
#  ultrawide monitors: toggle window size between 34% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

if $ULTRAWIDE
then
	FINALWIDTH=$SCREENWIDTH034
	#Difference between window width and 34% screen width
	SCREENWIDTHDIFF=$(($WIDTH-$SCREENWIDTH034))
else
	FINALWIDTH=$SCREENWIDTH050
	#Difference between window width and 50% screen width
	SCREENWIDTHDIFF=$(($WIDTH-$SCREENWIDTH050))
fi
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#Move to West
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $PANELLEFT 0

#Resize and move window to the left
#  wide monitors: window width 66% by default. If already 66% make it 50% wide
#  ultrawide monitors: window width 34% by default. If already 34% make it 50% wide
if [ $X -lt 100 ] && [ $Y -lt 100 ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
	if $ULTRAWIDE
	then
		FINALWIDTH=$SCREENWIDTH050
		echo "WIDTH is close to SCREENWIDTH*0.34. Make it 50% then move to the left"
	else
		FINALWIDTH=$SCREENWIDTH066
		echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left"
	fi
    xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $PANELLEFT 0
fi

CHECK=1
while [ $CHECK -lt 10 ]
do
	eval `xdotool getwindowgeometry --shell $WINDOW`
	if [ $X -gt 100 ]
	then
		echo "X=$X not right. Subtract CHECK*5px=$(($CHECK*4)) to SCREENHEIGHT "
    	xdotool windowsize $WINDOW $FINALWIDTH $(($SCREENHEIGHT-$CHECK*4)) #--sync can make it hang
    	xdotool windowmove $WINDOW $PANELLEFT 0
    	CHECK=$(($CHECK+1))
    else 
    	CHECK=10
	fi
done
