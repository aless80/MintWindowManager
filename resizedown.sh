#\bin\bash
set -x

#Move the current window North West toggling its size between 66% and 50% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

#Get screen width and height
SCREENWIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
SCREENHEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

#Get mate panels
PANELBOTTOM=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/bottom/ size)
PANELLEFT=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/toplevel-0/ size)

#Correct for panels
SCREENWIDTH=$(($SCREENWIDTH - $PANELLEFT))
SCREENHEIGHT=$(($SCREENHEIGHT - $PANELBOTTOM))

#Calculate here the 33%, 66%, 50% of screen height
SCREENHEIGHT025=$(($SCREENHEIGHT/100*25))
SCREENHEIGHT033=$(($SCREENHEIGHT/100*33))
SCREENHEIGHT050=$(($SCREENHEIGHT/2))
SCREENHEIGHT066=$(($SCREENHEIGHT/100*66))

#Calculate here the 66%, 50% of screen height. Below I give a 100 'margin' to evaluate window size
#SCREENWIDTH066=$(($SCREENWIDTH/100*66))
#SCREENWIDTH050=$(($SCREENWIDTH/2))

#First resize toggle maximization off but only if already maximized otherwise somehow the window gets maximized and it is ugly
if [ $WIDTH -gt $(($SCREENWIDTH-100)) ] && [ $HEIGHT -gt $(($SCREENHEIGHT-100)) ] 
then 
	echo "Remove maximization"
	wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
fi

#If window has about 33% of screen height, make it 25%
#Difference between window height and 33% screen height
SCREENHEIGHTDIFF=$(($HEIGHT-$SCREENHEIGHT033))
SCREENHEIGHTDIFF=${SCREENHEIGHTDIFF#-} #modulus
if [ $SCREENHEIGHTDIFF -lt $HEIGHTDIFFCONST ]
then
    echo "HEIGHT is close to SCREENHEIGHT*0.33. Make it 25% of screen height"
    WINDOWHEIGHT=$SCREENHEIGHT025
fi

#If window has about 50% of screen height, make it 33%
#Difference between window height and 50% screen height
SCREENHEIGHTDIFF=$(($HEIGHT-$SCREENHEIGHT050))
SCREENHEIGHTDIFF=${SCREENHEIGHTDIFF#-} #modulus
if [ $SCREENHEIGHTDIFF -lt $HEIGHTDIFFCONST ]
then
    echo "HEIGHT is close to SCREENHEIGHT*0.5. Make it 33% of screen height"
    WINDOWHEIGHT=$SCREENHEIGHT033
fi

#If window has about 66% of screen height, make it 50%
#Difference between window height and 66% screen height
SCREENHEIGHTDIFF=$(($HEIGHT-$SCREENHEIGHT066))
SCREENHEIGHTDIFF=${SCREENHEIGHTDIFF#-} #modulus
if [ $SCREENHEIGHTDIFF -lt $HEIGHTDIFFCONST ]
then
    echo "HEIGHT is close to SCREENHEIGHT*0.66. Make it 50% of screen height"
    WINDOWHEIGHT=$SCREENHEIGHT050
fi

#If window is bigger than 66% of screen height, make it 66%
#Difference between window height and 50% screen height
SCREENHEIGHTDIFF=$(($HEIGHT-$SCREENHEIGHT066)) #no modulus this time
if [ $SCREENHEIGHTDIFF -gt 100 ]
then
    echo "HEIGHT is greater than SCREENHEIGHT*0.66. Make it 66% of screen height"
    WINDOWHEIGHT=$SCREENHEIGHT066
fi

#Do the resizing and moving
xdotool windowsize $WINDOW $WIDTH $WINDOWHEIGHT
if [ $Y -gt 100 ]
then
    xdotool windowmove $WINDOW $X $(($SCREENHEIGHT-$WINDOWHEIGHT))
fi


#move to left
if [ $X -lt $HEIGHTDIFFCONST ]
then
    echo "X position is lower than $HEIGHTDIFFCONST px. Move the window to the west and keep the same y position"
    xdotool windowmove $WINDOW $PANELLEFT y
    #sometimes (eg when window is in NW position) the $Y variable is off for some reason. move to top
    if [ $Y -lt $HEIGHTDIFFCONST ]
    then
        echo "Y position is lower than $HEIGHTDIFFCONST px. Move the window to the top of the screen"
        xdotool windowmove $WINDOW x 0
    fi
fi

