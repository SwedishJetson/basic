#This is piece two of a two piece bash script that can be used to parse through text-based NMAP results (nmap_results.txt).
#The purpose is to quickly and cleanly see the services that are being run on a network.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash 
 
#There is no need to run this script. It is run from within the nmap_parser1.sh script. 
 
if [ $# -lt 2 ] ; 
then 
    echo usage : $0 protocols $2 
    exit 1 
fi 
 
filename=$1 
namp_results=$2 
filelines=`cat $filename` 
 
for proto in $filelines ; do 
    echo 
    echo $proto 
    echo "====================" 
    cat $2 | grep -B20 $proto > results.txt 
    grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' results.txt 
done 
