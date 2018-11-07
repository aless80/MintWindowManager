#\bin\bash
set -x

#Move the current window East toggling its size between 34% and 50% of the screen width

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

#Calculate here the 34%, 50% of screen width. Below I give a 100 'margin' to evaluate window size
SCREENWIDTH034=$(($SCREENWIDTH/100*34))
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

#Move to East
xdotool windowsize $WINDOW $SCREENWIDTH050 $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH050)) 0

#Resize and move window to the right
#Make window 50% of the screen width by default. If already 50% of the width, make it 34%
if [ $X -gt 100 ] && [ $Y -lt 100 ] && [ $SCREENWIDTHDIFF -lt 100 ]
then
    echo "WIDTH is close to SCREENWIDTH*0.5. Make it 34% then move to the right part of the screen"
    xdotool windowsize $WINDOW $(($SCREENWIDTH034)) $SCREENHEIGHT #--sync can make it hang
    xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH-$SCREENWIDTH034)) 0
fi