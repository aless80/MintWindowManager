#\bin\bash
#set -x

#Move the current window West toggling its size between 66% and 50% of the screen width

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
for (( n=0; n<=4; n++ ))
do 
    ORIENTATION=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/toplevel-"$n"/ orientation);
    echo "$n - ORIENTATION = $ORIENTATION"
    if [ $ORIENTATION = "left" ]
    then
        PANELLEFT=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/toplevel-"$n"/ size)
        echo "PANELLEFT = $PANELLEFT"
    fi
    
done

#$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/bottom/ orientation) #"bottom"
PANELBOTTOM=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/bottom/ size)
PANELLEFT=$(gsettings get org.mate.panel.toplevel:/org/mate/panel/toplevels/toplevel-0/ size)

#Correct for panels
SCREENWIDTH=$(($SCREENWIDTH - $PANELLEFT))
SCREENHEIGHT=$(($SCREENHEIGHT - $PANELBOTTOM))

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
