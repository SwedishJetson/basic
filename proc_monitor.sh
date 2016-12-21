#This script is built to monitor processes without using the top command. 
#It can also be used to monitor for potentially malicious scripts. 
#This is accomplished with 30 second snapshots of the running processes. 
#The differences are output to the file proc.lst 

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash 
 
while ((i=0,i < 6, i++)); do 
 
baseline=$(ps > /home/User/Desktop/procmonix/baseline.txt) 
 
bash 
 
sleep 30 
 
comparison=$(ps > /home/User/Desktop/procmonix/comparison.txt) 
 
if [[ $baseline_$i -eq $comparison ]] ; then 
    echo "Running process HAVE NOT changed." 
else 
    echo "Running process HAVE changed." 
 
    date >> /home/User/Desktop/procmonix/procmonix/proc.lst 
    diff baseline.txt comparison.txt >> /home/User/Desktop/procmonix/proc.lst 
 
    echo "Here are the changes.." 
 
    cat /home/user/Desktop/procmonix/proc.lst 
fi 
 
exit 
 
#done 
