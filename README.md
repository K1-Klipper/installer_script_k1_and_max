# How to use:
```
cd /usr/data
wget --no-check-certificate https://raw.githubusercontent.com/K1-Klipper/installer_script_k1_and_max/main/installer.sh
chmod +x installer.sh
./installer.sh
```


## What this does:

Creality shipped klipper that had not been updated since 2022. As such it was missing many patches and new features that had been added to the main repository. This will install the updated klipper for K1 found at

https://github.com/K1-Klipper/klipper


This is a community based effort to keep klipper up to date for the K1/Max


## Things to note:

This installer will edit: <br>
1)Printer.cfg <br>
2)gcode_macro.cfg <br>
3)sensorless.cfg <br>

if you run into issues please download backups of those files from creality's github found here:
https://github.com/CrealityOfficial/K1_Series_Klipper/tree/main/config
