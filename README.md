# MateWM
Window Manager for Linux Mint Mate

### Description
Bash scripts to tile a window on a certain position of the screen. The scripts can be used with keyboard shortcuts and are probably most helpful when used on a computer with large monitor. 

I will use cardinal directions such as NW for North West to describe the positions on the screen. The scripts resize the current window to 50% of the screen width and move them to the corresponding cardinal position. When a script is invoked a second time, thewindow will be resized to 66% or 34% of the screen width for windows tiled on the West or East, respectively. 

For Linux Mint MATE the scripts take into account MATE panels on the bottom and on the left (if any). I personally use the following keyboard shortcuts to the following scripts: 

--------
| Ctrl + WinKey + Left | mvSW.sh |
| Ctrl + WinKey + Right | mvSE.sh |
| Shift + Ctrl + WinKey + Left | mvNW.sh |
| Shift + Ctrl + WinKey + Right | mvNE.sh |
| Ctrl + WinKey + Page Up | mvW.sh |
| Ctrl + WinKey + Page Down | mvE.sh |
--------
