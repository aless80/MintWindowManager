# MateWM
Window Manager for Linux Mint Mate

### Description
Bash scripts to tile a window on a certain position of the screen. The scripts can be used with keyboard shortcuts and are probably most helpful when used on a computer with large monitor. 

I will use cardinal directions such as NW for North West to describe the positions on the screen. The scripts resize the current window to 50% of the screen width and move them to the corresponding cardinal position. When a script is invoked a second time, thewindow will be resized to 66% or 34% of the screen width for windows tiled on the West or East, respectively. 

For Linux Mint MATE the scripts take into account MATE panels on the bottom and on the left (if any). I personally use the following keyboard shortcuts to the following scripts: 


| Keyboard Shortcut | Script | Action |
| :-------- | -------- | -------|
| Ctrl + WinKey + Left | mvSW.sh | Move window to the Bottom Left corner, resize to 50% or 66% screen width |
| Ctrl + WinKey + Right | mvSE.sh | Move window to the Bottom Right corner, resize to 50% or 34% screen width |
| Shift + Ctrl + WinKey + Left | mvNW.sh | Move window to the Top Left corner, resize to 50% or 66% screen width |
| Shift + Ctrl + WinKey + Right | mvNE.sh | Move window to the Top Right corner, resize to 50% or 34% screen width |
| Ctrl + WinKey + Page Up | mvW.sh | Move window to the Left, resize to 50% or 66% screen width |
| Ctrl + WinKey + Page Down | mvE.sh | Move window to the Right, resize to 50% or 34% screen width |

