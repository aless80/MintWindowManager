#\bin\bash
#set -x

#Move the current window to the center
#  ultrawide monitors: make window size 34% of the screen width

#Get the directory of this script
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#Get variables: window properties (ID, X, Y, WIDTH, HEIGHT), screen width and height, panels, 
. "$THIS_DIR/config.sh"

FINALWIDTH=$SCREENWIDTH034

#Move to East
xdotool windowsize $WINDOW $FINALWIDTH $SCREENHEIGHT
xdotool windowmove $WINDOW $(($PANELLEFT+$SCREENWIDTH034)) 0
