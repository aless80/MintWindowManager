#\bin\bash
#set -x

#Move the current window South West toggling its size between 66% and 50% of the screen width

#Get vars with window properties (X, Y, WIDTH, HEIGHT)
WINDOW=$(xdotool getwindowfocus)
eval `xdotool getwindowgeometry --shell $WINDOW`

#You can pass the window ID to the script
if [ $# -eq 1 ] 
then 
    WINDOW=$1
fi

#Get screen width and height
SCREENWIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
SCREENHEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

#Get mate panels
PANELBOTTOM=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/bottom/ size)
PANELLEFT=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/toplevel-0/ size)

#Correct for panels
SCREENWIDTH=$(($SCREENWIDTH - $PANELLEFT))
SCREENHEIGHT=$(($SCREENHEIGHT - $PANELBOTTOM))
SCREENHEIGHT050=$(($SCREENHEIGHT/2))

#Calculate here the 66%, 50% of screen width. Below I give a 100 'margin' to evaluate window size
SCREENWIDTH066=$(($SCREENWIDTH/100*66))
SCREENWIDTH050=$(($SCREENWIDTH/2))
#Difference between window width and 50% screen width
SCREENWIDTHDIFF=$(($WIDTH-$SCREENWIDTH050))
SCREENWIDTHDIFF=${SCREENWIDTHDIFF#-} #modulus

#First resize toggle maximization off but only if already maximized otherwise somehow the window gets maximized and it is ugly
if [ $WIDTH -gt $(($SCREENWIDTH-100)) ] && [ $HEIGHT -gt $(($SCREENHEIGHT-100)) ] 
then 
	echo "Remove maximization"
	wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
fi

#Move to South West, for now 50% 50%
xdotool windowsize $WINDOW $SCREENWIDTH050 $SCREENHEIGHT050
xdotool windowmove $WINDOW $PANELLEFT $SCREENHEIGHT050

#Resize and move window to the left
#Made window 50% of the screen width by default. If already 50% of the width, make it 66%
if [ $X -lt 100 ] && [ $Y -gt $((SCREENHEIGHT050-100)) ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
    echo "WIDTH is close to SCREENWIDTH*0.5. Make it 66% then move to the left part of the screen"
    xdotool windowsize $WINDOW $SCREENWIDTH066 $SCREENHEIGHT050 #--sync can make it hang
    xdotool windowmove $WINDOW $PANELLEFT $SCREENHEIGHT050
fi
