#\bin\bash
#set -x

#Get panels
release=`env | grep DESKTOP_SESSION= | sed 's/DESKTOP_SESSION=//'`

PANELLEFT=0
PANELBOTTOM=31 #26/31/31/0 minimum to make terminal/subl/firefox/chrome work when panel bottom is not expanded
PANELTOP=0
PANELRIGHT=0
PANELS=(`dconf list /org/${release}/panel/toplevels/`)
for p in "${PANELS[@]}"; 
do
	orientation=(`dconf read /org/${release}/panel/toplevels/${p}orientation | sed "s/'//g"`);
	size=`dconf read /org/${release}/panel/toplevels/${p}size`
	if [[ "$size" = "" ]] ; then size=0; fi
	echo "$p $orientation $size"
	case $orientation in
		bottom) PANELBOTTOM=$((PANELBOTTOM + $size));;
		left) 	PANELLEFT=$((PANELLEFT + $size));;
		top) 	PANELTOP=$((PANELTOP + $size));;
		right) 	PANELRIGHT=$((PANELRIGHT + $size));;
	esac
done


#You can pass the window ID to the script, or get the current window
if [ $# -eq 1 ] 
then 
    WINDOW=$1
else
	WINDOW=$(xdotool getwindowfocus)
fi

#Get vars with window properties (X, Y, WIDTH, HEIGHT)
eval `xdotool getwindowgeometry --shell $WINDOW`

#Get monitor width and height
MONITORWIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
MONITORHEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

#Correct for panels
SCREENWIDTH=$(($MONITORWIDTH - $PANELLEFT))
SCREENHEIGHT=$(($MONITORHEIGHT - $PANELBOTTOM))
SCREENHEIGHT050=$(($MONITORHEIGHT/2))

#Calculate 66%, 50% of screen width. Below I give a 100 'margin' to evaluate window size
SCREENWIDTH066=$(($SCREENWIDTH/100*66))
SCREENWIDTH050=$(($SCREENWIDTH/2))

#Calculate 34%, 50% of screen width. Below I give a 100 'margin' to evaluate window size
SCREENWIDTH034=$(($SCREENWIDTH/100*34))
SCREENWIDTH050=$(($SCREENWIDTH/2))

#Resize toggle maximization off but only if already maximized otherwise somehow the window gets maximized and it is ugly
if [ $WIDTH -gt $(($SCREENWIDTH-100)) ] && [ $HEIGHT -gt $(($SCREENHEIGHT-100)) ] 
then 
    echo "Remove maximization"
	wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
fi

echo "MONITORHEIGHT = $MONITORHEIGHT"
echo "SCREENHEIGHT = $SCREENHEIGHT"
echo "PANELBOTTOM = $PANELBOTTOM"