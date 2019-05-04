#\bin\bash
#set -x

#Move the current window West toggling its size between 66% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

#Move to West
xdotool windowsize $WINDOW $SCREENWIDTH050 $SCREENHEIGHT
xdotool windowmove $WINDOW $PANELLEFT 0

#Resize and move window to the left
#Make window 66% of the screen width by default. If already 66% of the width, make it 50%
if [ $X -lt 100 ] && [ $Y -lt 100 ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
    echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left part of the screen"
    xdotool windowsize $WINDOW $SCREENWIDTH066 $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $PANELLEFT 0
fi

CHECK=1
while [ $CHECK -lt 10 ]
do
	eval `xdotool getwindowgeometry --shell $WINDOW`
	if [ $X -gt 100 ]
	then
		echo "X=$X not right. Subtract CHECK*5px=$(($CHECK*4)) to SCREENHEIGHT "
    	xdotool windowsize $WINDOW $SCREENWIDTH066 $(($SCREENHEIGHT-$CHECK*4)) #--sync can make it hang
    	xdotool windowmove $WINDOW $PANELLEFT 0
    	CHECK=$(($CHECK+1))
    else 
    	CHECK=10
	fi
done
