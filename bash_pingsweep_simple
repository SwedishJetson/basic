#This is a bash script that uses native Linux tools to ping a pre-determined range of hosts.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash

for ip in $(seq 1 254); do
2&>/dev/null
ping -c 1 192.168.188.$ip| grep 'bytes from' |cut -d" " -f4|cut -d":" -f1| sort &
done
