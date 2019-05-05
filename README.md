# MateWM
Window Manager for Linux Mint Mate

### Description
Bash scripts to tile a window on a certain position of the screen and resizes them. The scripts can be used with keyboard shortcuts. The scripts are most suitable for Linux computers using relatively wide monitors because they resize windows to 34%, 50%, or 66% of the screen width. More specifically, I developed these scripts working on a 27" monitor and a 37.5" Curved one.

## Dependencies
sudo apt install xdotool wmctrl dconf x11-xserver-utils

### Description of bash scripts 
This repository includes two types of script: scripts that tile windows (the mv\*.sh scripts) and scripts that resize windows by changing their heights (the resize\*.sh scripts). The window width depend on the resolution width of the display; if greater than 3200px I assume the monitor is "ultrawide" (e.g. monitor width is 37.5" or more). 

I will use cardinal directions such as E for East, NW for North West, C for Center to describe the positions on the screen. The mv\*.sh scripts resize the current window to 50% (34% for ultrawide monitors) of the screen width and move them to the corresponding cardinal position. When a script is invoked a second time, the window will be resized to 66% or 34% (50% for ultrawide monitors) of the screen width for windows tiled on the West or East, respectively. 

The resize\*.sh scripts resize the height of the windows. By invoking the scripts multiple times, windows can be resized to a height of 25%, 33%, 50%, 66%, 75%.

For Linux Mint MATE the scripts take into account MATE panels on the bottom and on the left (if any). 

### Keyboard Shortcuts
I personally use the following keyboard shortcuts to the following scripts: 

| Keyboard Shortcut | Script | Action |
| :-------- | -------- | -------|
| Ctrl + WinKey + Up | resizeup.sh | Increase a window's height to 33%, 50%, 66%, or 75% of the screen height |
| Ctrl + WinKey + Down | resizedown.sh | Decrease a window's height to 25%,33%, 50%, or 66% of the screen height |

For "normally" wide monitors about 27" wide:

| | | |
| :-------- | -------- | -------|
| Ctrl + WinKey + Page Up | mvW.sh | Move window to the Left, resize to 50% or 66% of screen width |
| Ctrl + WinKey + Page Down | mvE.sh | Move window to the Right, resize to 50% or 34% of screen width |
| Ctrl + WinKey + Left | mvSW.sh | Move window to the Bottom Left corner, resize to 50% or 66% of screen width |
| Ctrl + WinKey + Right | mvSE.sh | Move window to the Bottom Right corner, resize to 50% or 34% of screen width |
| Shift + Ctrl + WinKey + Left | mvNW.sh | Move window to the Top Left corner, resize to 50% or 66% of screen width |
| Shift + Ctrl + WinKey + Right | mvNE.sh | Move window to the Top Right corner, resize to 50% or 34% of screen width |

For ultrawide monitors 37.5" wide and more: 

| | | |
| :-------- | -------- | -------|
| Ctrl + WinKey + 1 | mvW.sh | Move window to the Left, resize to 34% or 50% of screen width |
| Ctrl + WinKey + 2 | mvC.sh | Move window to the Center, resize to 34% of screen width |
| Ctrl + WinKey + 3 | mvW.sh | Move window to the Right, resize to 34% or 50% of screen width |

These keyboard shortcuts can be programmatically set by using these lines of code: 

```
#Change the following variable to the installation path
INSTALLATIONPATH="Dropbox/scripts/MateWM"

RELEASE=`env | grep DESKTOP_SESSION= | sed 's/DESKTOP_SESSION=//'`

#any monitor
dconf write /org/${RELEASE}/desktop/keybindings/custom20/action "'bash ${INSTALLATIONPATH}/resizeup.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom20/name "'resizeup'"
dconf write /org/${RELEASE}/desktop/keybindings/custom20/binding "'<Primary><Mod4>Up'"

dconf write /org/${RELEASE}/desktop/keybindings/custom21/action "'bash ${INSTALLATIONPATH}/resizedown.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom21/name "'resizedown'"
dconf write /org/${RELEASE}/desktop/keybindings/custom21/binding "'<Primary><Mod4>Down'"

#wide monitors
dconf write /org/${RELEASE}/desktop/keybindings/custom22/action "'bash ${INSTALLATIONPATH}/mvW.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom22/name "'mvW'"
dconf write /org/${RELEASE}/desktop/keybindings/custom22/binding "'<Primary><Mod4>Page_Up'"

dconf write /org/${RELEASE}/desktop/keybindings/custom23/action "'bash ${INSTALLATIONPATH}/mvE.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom23/name "'mvE'"
dconf write /org/${RELEASE}/desktop/keybindings/custom23/binding "'<Primary><Mod4>Page_Down'"

dconf write /org/${RELEASE}/desktop/keybindings/custom24/action "'bash ${INSTALLATIONPATH}/mvSW.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom24/name "'mvSW'"
dconf write /org/${RELEASE}/desktop/keybindings/custom24/binding "'<Primary><Mod4>Left'"

dconf write /org/${RELEASE}/desktop/keybindings/custom25/action "'bash ${INSTALLATIONPATH}/mvSE.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom25/name "'mvSE'"
dconf write /org/${RELEASE}/desktop/keybindings/custom25/binding "'<Primary><Mod4>Right'"

dconf write /org/${RELEASE}/desktop/keybindings/custom26/action "'bash ${INSTALLATIONPATH}/mvNW.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom26/name "'mvNW'"
dconf write /org/${RELEASE}/desktop/keybindings/custom26/binding "'<Primary><Shift><Mod4>Left'"

dconf write /org/${RELEASE}/desktop/keybindings/custom27/action "'bash ${INSTALLATIONPATH}/mvNE.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom27/name "'mvNE'"
dconf write /org/${RELEASE}/desktop/keybindings/custom27/binding "'<Primary><Shift><Mod4>Right'"

#ultrawide monitors
dconf write /org/${RELEASE}/desktop/keybindings/custom28/action "'bash ${INSTALLATIONPATH}/mvW.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom28/name "'mvW'"
dconf write /org/${RELEASE}/desktop/keybindings/custom28/binding "'<Primary><Mod4>1'"

dconf write /org/${RELEASE}/desktop/keybindings/custom29/action "'bash ${INSTALLATIONPATH}/mvC.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom29/name "'mvC'"
dconf write /org/${RELEASE}/desktop/keybindings/custom29/binding "'<Primary><Mod4>2'"

dconf write /org/${RELEASE}/desktop/keybindings/custom30/action "'bash ${INSTALLATIONPATH}/mvE.sh'"
dconf write /org/${RELEASE}/desktop/keybindings/custom30/name "'mvE'"
dconf write /org/${RELEASE}/desktop/keybindings/custom30/binding "'<Primary><Mod4>3'"
```