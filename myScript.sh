#/usr/bin/env bash

#Create an AVD
android create avd -n TestAppVigil -t 6 -c 512M --force

#Starting the emulator 
emulator -avd TestAppVigil -no-skin -no-audio -no-window &

#Checking if the emulator is fully booted or not	
OUT=`adb shell getprop init.svc.bootanim`
RES="stopped"
 
while [[ ${OUT:0:7}  != 'stopped' ]]; do
		OUT=`adb shell getprop init.svc.bootanim`
		echo 'Waiting for emulator to fully boot...'
		sleep 30
done
 
echo "Emulator booted!"

#Installing the app as given in argument [app.apk]
adb install  /home/sarsjits/Desktop/myScript/$1
echo "App Installed Successfully!"

#Use aapt to get the package name and launchable activity 
#aapt dump badging <app.apk>
#for the app in the myScript folder

echo "Starting the First Activity"

#Now after finding out package name and launchable activity use them to start the activity
adb shell am start -n com.gpt.videotomp3/com.gpt.videotomp3.VideoCutter

echo "Activity Started Successfully"

#Now to take the screenshot
adb shell /system/bin/screencap -p /sdcard/$2
adb pull /sdcard/screenshot.png /home/sarsjits/Desktop/myScript/$2

echo "Screenshot Saved Successfully"

#Uninstalling the App
adb uninstall com.gpt.videotomp3

echo "App Uninstalled Successfully"

#Deleting the avd
android delete avd -n TestAppVigil

echo "AVD Deleted Successfully!"
echo "Yipee! have a good day!"
