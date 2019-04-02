# MateWM
Window Manager for Linux Mint Mate

### Description
Bash scripts to tile a window on a certain position of the screen and resizes them. The scripts can be used with keyboard shortcuts. The scripts are most suitable for Linux computers using wide monitors because they resize windows to 34%, 50%, or 66% of the screen width. 

## Dependencies
sudo apt install xdotool wmctrl x11-xserver-utils

### Description of bash scripts 
This repository includes two types of script: scripts that tile windows (the mv\*.sh scripts) and scripts that resize windows by changing their heights (the resize\*.sh scripts).  

I will use cardinal directions such as NW for North West to describe the positions on the screen. The mv\*.sh scripts resize the current window to 50% of the screen width and move them to the corresponding cardinal position. When a script is invoked a second time, the window will be resized to 66% or 34% of the screen width for windows tiled on the West or East, respectively. 

The resize\*.sh scripts resize the height of the windows. By invoking the scripts multiple times, windows can be resized to 25%,33%, 50%, 66%, 75%.

For Linux Mint MATE the scripts take into account MATE panels on the bottom and on the left (if any). I personally use the following keyboard shortcuts to the following scripts: 


| Keyboard Shortcut | Script | Action |
| :-------- | -------- | -------|
| Ctrl + WinKey + Left | mvSW.sh | Move window to the Bottom Left corner, resize to 50% or 66% screen width |
| Ctrl + WinKey + Right | mvSE.sh | Move window to the Bottom Right corner, resize to 50% or 34% screen width |
| Shift + Ctrl + WinKey + Left | mvNW.sh | Move window to the Top Left corner, resize to 50% or 66% screen width |
| Shift + Ctrl + WinKey + Right | mvNE.sh | Move window to the Top Right corner, resize to 50% or 34% screen width |
| Ctrl + WinKey + Page Up | mvW.sh | Move window to the Left, resize to 50% or 66% screen width |
| Ctrl + WinKey + Page Down | mvE.sh | Move window to the Right, resize to 50% or 34% screen width |
| Ctrl + WinKey + Up | resizeup.sh | Increase a window's height to 33%, 50%, 66%, or 75% of the screen height |
| Ctrl + WinKey + Down | resizedown.sh | Decrease a window's height to 25%,33%, 50%, or 66% of the screen height |
