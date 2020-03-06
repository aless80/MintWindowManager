#\bin\bash
#set -x

#This script estimates whether a monitor is normal or ultrawide. Unfortunately xrandr and xdpyinfo cannot adequately estimate the monitor physical size. If you need to override the estimate ULTRAWIDE variable. 
#There is also some degree of uncertainty in estimating windows positions and sizes, whichis due to the window's header. This is taken into account in the HEIGHTDIFFCONST variable, which on my computers is about 104 pixels. 

#You can pass the window ID to the script, or get the current window
if [ $# -eq 1 ] && [ "$1" != "x" ] 
then 
    WINDOW=$1
else
	WINDOW=$(xdotool getwindowfocus)
fi

#Get vars with window properties (X, Y, WIDTH, HEIGHT)
eval `xdotool getwindowgeometry --shell $WINDOW`

#This variable is used to compare windows Y positions and HEIGHTS, which unfortunately have some degree of uncertainty
HEIGHTDIFFCONST=105

#Get panels
RELEASE=`env | grep DESKTOP_SESSION= | sed 's/DESKTOP_SESSION=//'`
PANELLEFT=0
PANELBOTTOM=31 #26/31/31/0 minimum to make terminal/subl/firefox/chrome work when panel bottom is not expanded
PANELTOP=0
PANELRIGHT=0
PANELS=(`dconf list /org/${RELEASE}/panel/toplevels/`)
for p in "${PANELS[@]}"; 
do
	orientation=(`dconf read /org/${RELEASE}/panel/toplevels/${p}orientation | sed "s/'//g"`);
	size=`dconf read /org/${RELEASE}/panel/toplevels/${p}size`
	if [[ "$size" = "" ]] ; then size=0; fi
	#echo "$p $orientation $size"
	case $orientation in
		bottom) PANELBOTTOM=$((PANELBOTTOM + $size));;
		left) 	PANELLEFT=$((PANELLEFT + $size));;
		top) 	PANELTOP=$((PANELTOP + $size));;
		right) 	PANELRIGHT=$((PANELRIGHT + $size));;
	esac
done

#Get number of monitors
MONITORS=$(xrandr | grep " connected " | wc -l)

#Get monitor resolution
MONITORWIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
MONITORHEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

#Get physical size of monitor. Unfortunately xrandr is wrong with my ultrawide 37.5" external monitor!
MONITORWIDTHMM=$(xrandr | grep ' connected' | grep 'mm x ' | uniq | awk -Fmm '{print $1}' | awk '{print $NF}')
MONITORHEIGHTMM=$(xrandr | grep ' connected' | grep 'mm x ' | uniq | awk -Fmm '{print $2}' | awk '{print $2}')

#Hopefully xdpyinfo is better TODO: CHECK! 
MONITORWIDTHMM2=$(xdpyinfo | grep 'dimensions:' | awk -F\( '{print $2}' | awk -Fx '{print $1}')
MONITORHEIGHTMM2=$(xdpyinfo | grep 'dimensions:' | awk -F\( '{print $2}' | awk -Fx '{print $NF}' | awk '{print $1}')

if [ $MONITORWIDTHMM2 -gt $MONITORWIDTHMM ]
then 
	echo "MONITORWIDTHMM MONITORWIDTHMM2 = $MONITORWIDTHMM $MONITORWIDTHMM2 "
	MONITORWIDTHMM=$MONITORWIDTHMM2
	echo "MONITORWIDTHMM MONITORWIDTHMM2 = $MONITORWIDTHMM $MONITORWIDTHMM2 "
fi

#Estimate if monitor is normal or ultrawide
ULTRAWIDE=false
if [ $MONITORS -gt 1 ]
then	
	#Check resolution to estimate if monitor is ULTRAWIDE
	if [ $MONITORWIDTHMM -gt 600 ]
	then ULTRAWIDE=true
	fi
fi
echo "ULTRAWIDE: $ULTRAWIDE"

#Correct for panels
SCREENWIDTH=$(($MONITORWIDTH - $PANELLEFT))
SCREENHEIGHT=$(($MONITORHEIGHT - $PANELBOTTOM))

#Calculate 50% of screen height
SCREENHEIGHT050=$(($MONITORHEIGHT/2))

#Calculate 66%, 50%, 34% of screen width
SCREENWIDTH066=$(($SCREENWIDTH/100*66))
SCREENWIDTH050=$(($SCREENWIDTH/2))
SCREENWIDTH048=$(($SCREENWIDTH/100*48))
SCREENWIDTH033=$(($SCREENWIDTH/100*33))
SCREENWIDTH025=$(($SCREENWIDTH/100*25))

#Resize toggle maximization off but only if already maximized otherwise somehow the window gets maximized and it is ugly
if [ $WIDTH -gt $(($SCREENWIDTH-100)) ] && [ $HEIGHT -gt $(($SCREENHEIGHT-100)) ] 
then 
    echo "Remove maximization"
	wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
fi

#This applies to ultrawide screens. I like to have a center window wider (48% by default) than the lateral ones (25% by default).
SCREENWIDTHULTRA=$SCREENWIDTH048
SCREENWIDTHULTRALATERAL=$SCREENWIDTH025

echo "" 
echo "" 
