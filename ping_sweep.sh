#This is a bash script that uses native Linux tools to ping a given range of hosts.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash 
 
rm results.txt 2>/dev/null 
 
echo "What size is your target network? Options are <8, 16, or 24>." 
read -e size 
 
#for a /8 network 
if [[ $size = 8 ]] ; then 
    echo "Please enter the first octet of the ip range to scan. Enter like <10>." 
    read -e range 
    for i in `seq 1 255` 
    do     
        ping -c 1 $range.$i.$i.$i 
        if [[ $? -eq 0 ]] ; then 
        echo $range.$i.$i.$i responded. >> results.txt 
        echo  
        fi 
    done 
 
#for a /16 network 
elif [[ $size = 16 ]] ; then 
    echo "Please enter the first octet of the ip range to scan. Enter like <192>." 
    read -e range1 
    echo "Please enter the second octet of the ip range to scan. Enter like <168>." 
    read -e range2 
    for i in `seq 1 255` 
    do     
        ping -c 1 $range1.$range2.$i.$i 
        if [[ $? -eq 0 ]] ; then 
        echo $range1.$range2.$i.$i responded. >> results.txt 
        echo  
        fi 
    done 
 
#for a /24 network 
elif [[ $size = 24 ]] ; then 
    echo "Please enter the first octet of the ip range to scan. Enter like <192>." 
    read -e range1 
    echo "Please enter the second octet of the ip range to scan. Enter like <168>." 
    read -e range2 
    echo "Please enter the third octet of the ip range to scan. Enter like <125>." 
    read -e range3 
    for i in `seq 220 240` 
    do     
        ping -c 1 $range1.$range2.$range3.$i 
        if [[ $? -eq 0 ]] ; then 
        echo $range1.$range2.$range3.$i >> results.txt 
        nc -zv $range1.$range2.$range3.$i 1-1023 >> results.txt 
        echo  
        fi 
    done 
fi 
 
echo "Complete!" 
echo "Here are your results!" 
echo ********************************* 
cat results.txt 
echo ********************************* 
exit 
 
 
exit 
