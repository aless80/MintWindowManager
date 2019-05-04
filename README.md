# MateWM
Window Manager for Linux Mint Mate

### Description
Bash scripts to tile a window on a certain position of the screen and resizes them. The scripts can be used with keyboard shortcuts. The scripts are most suitable for Linux computers using wide monitors because they resize windows to 34%, 50%, or 66% of the screen width. 

## Dependencies
sudo apt install xdotool wmctrl dconf x11-xserver-utils

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

This can be programmatically achieved by using these lines of code: 
first change 'mate' to your edition (e.g. cinnamon), and the path to this repository:

```
dconf write /org/mate/desktop/keybindings/custom20/action "'bash Dropbox/scripts/MateWM/mvSW.sh'"
dconf write /org/mate/desktop/keybindings/custom20/name "'mvSW'"
dconf write /org/mate/desktop/keybindings/custom20/binding "'<Primary><Mod4>Left'"

dconf write /org/mate/desktop/keybindings/custom21/action "'bash Dropbox/scripts/MateWM/mvSE.sh'"
dconf write /org/mate/desktop/keybindings/custom21/name "'mvSE'"
dconf write /org/mate/desktop/keybindings/custom21/binding "'<Primary><Mod4>Right'"

dconf write /org/mate/desktop/keybindings/custom22/action "'bash Dropbox/scripts/MateWM/mvNW.sh'"
dconf write /org/mate/desktop/keybindings/custom22/name "'mvNW'"
dconf write /org/mate/desktop/keybindings/custom22/binding "'<Primary><Shift><Mod4>Left'"

dconf write /org/mate/desktop/keybindings/custom23/action "'bash Dropbox/scripts/MateWM/mvNE.sh'"
dconf write /org/mate/desktop/keybindings/custom23/name "'mvNE'"
dconf write /org/mate/desktop/keybindings/custom23/binding "'<Primary><Shift><Mod4>Right'"

dconf write /org/mate/desktop/keybindings/custom24/action "'bash Dropbox/scripts/MateWM/mvW.sh'"
dconf write /org/mate/desktop/keybindings/custom24/name "'mvW'"
dconf write /org/mate/desktop/keybindings/custom24/binding "'<Primary><Mod4>Page_Up'"

dconf write /org/mate/desktop/keybindings/custom25/action "'bash Dropbox/scripts/MateWM/mvE.sh'"
dconf write /org/mate/desktop/keybindings/custom25/name "'mvE'"
dconf write /org/mate/desktop/keybindings/custom25/binding "'<Primary><Mod4>Page_Down'"

dconf write /org/mate/desktop/keybindings/custom26/action "'bash Dropbox/scripts/MateWM/resizeup.sh'"
dconf write /org/mate/desktop/keybindings/custom26/name "'resizeup'"
dconf write /org/mate/desktop/keybindings/custom26/binding "'<Primary><Mod4>Up'"

dconf write /org/mate/desktop/keybindings/custom27/action "'bash Dropbox/scripts/MateWM/resizedown.sh'"
dconf write /org/mate/desktop/keybindings/custom27/name "'resizedown'"
dconf write /org/mate/desktop/keybindings/custom27/binding "'<Primary><Mod4>Down'"
```