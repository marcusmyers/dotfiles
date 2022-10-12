#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

os=`cat /etc/ubuntu-release | awk '{printf "%s %s", $1, $3}'`
rootUsed=`df -h --output=used / | tail -n1 | tr -d ' \n'`
rootTotal=`df -h --output=size / | tail -n1 | tr -d ' \n'`
memUsed=`free -m | grep "Mem" | awk '{printf "%.1fG", $3/1000}'`
memTotal=`free -m | grep "Mem" | awk '{printf "%.fG", $2/1000}'`
cpuTemp=`sensors | grep CPU | awk '{print $2}' | sed 's/+//' | tr -d '\n'`
loadAvg=`cat /proc/loadavg | awk '{printf "%s %s %s", $1, $2, $3}'`

#printf $CYAN
printf '
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
' | lolcat-c
printf '
      Greetings Mark, welcome back!
' | lolcat-c
echo
# printf $GREEN
# echo
# fortune vimtips
# echo
# printf $NC
