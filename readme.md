# circadian wallpaper

This script sets a random wallpaper from a provided folder. During the day, it picks a brighter image. During the evening, it picks a darker image. You can define the rules for _day_ and _night_ by editing the script.  

When called, add a path to a folder with image files to pick a background from. The script then picks a random wallpaper from the 'brighter' half during the day and from the 'darker' half during the night. More instructions are available in the script. Only tested on Debian/Gnome environment.  


If you want to run this script, you can do two things. You can manually call it whenever you want to change your background. Or, you can periodically run it (e.g. with crontab). Note, to setup a cron schedule for a bash script, please refer to crontab's documentation.
```Shell
./cw.sh /home/wallpapers/
```

