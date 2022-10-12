#!/bin/bash

#os=`cat /etc/lsb-release | grep VERSION | awk '{printf "%s %s", $1, $3}'`
os=`cat /etc/os-release | grep PRETTY_NAME | awk '{gsub(/"/, "", $0);split($0,a,"="); print a[2]}'`
rootUsed=`df -h --output=used / | tail -n1 | tr -d ' \n'`
rootTotal=`df -h --output=size / | tail -n1 | tr -d ' \n'`
memUsed=`free -m | grep "Mem" | awk '{printf "%.1fG", $3/1000}'`
memTotal=`free -m | grep "Mem" | awk '{printf "%.fG", $2/1000}'`
cpuTemp=`sensors | grep Package | awk '{print $4}' | sed 's/+//' | tr -d '\n'`
loadAvg=`cat /proc/loadavg | awk '{printf "%s %s %s", $1, $2, $3}'`

printf "
MMMMMMMM               MMMMMMMM                                   
M:::::::M             M:::::::M                                   
M::::::::M           M::::::::M                                   
M:::::::::M         M:::::::::M                                   
M::::::::::M       M::::::::::M   ooooooooooo xxxxxxx      xxxxxxx
M:::::::::::M     M:::::::::::M oo:::::::::::oox:::::x    x:::::x 
M:::::::M::::M   M::::M:::::::Mo:::::::::::::::ox:::::x  x:::::x  
M::::::M M::::M M::::M M::::::Mo:::::ooooo:::::o x:::::xx:::::x   
M::::::M  M::::M::::M  M::::::Mo::::o     o::::o  x::::::::::x    
M::::::M   M:::::::M   M::::::Mo::::o     o::::o   x::::::::x     
M::::::M    M:::::M    M::::::Mo::::o     o::::o   x::::::::x     
M::::::M     MMMMM     M::::::Mo::::o     o::::o  x::::::::::x    
M::::::M               M::::::Mo:::::ooooo:::::o x:::::xx:::::x   
M::::::M               M::::::Mo:::::::::::::::ox:::::x  x:::::x  
M::::::M               M::::::M oo:::::::::::oox:::::x    x:::::x 
MMMMMMMM               MMMMMMMM   ooooooooooo xxxxxxx      xxxxxxx

  $os
 $rootUsed/$rootTotal   $memUsed/$memTotal   $cpuTemp  辰$loadAvg

      Greetings Mark, welcome back!
" | lolcat-c
