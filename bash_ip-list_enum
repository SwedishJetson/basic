#This is a bash script that accepts a text file list (from user input) of ips and performs the following actions: 
#pulls MAC address, hostname, OS, open ports (25 most popular), and mentions whether a device is Cisco or not.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash  
 
rm report.txt 2>/dev/null 
 
echo "Please enter filename to use. File should be a clean list of IPs, delimited with carriage returns." 
read -e filename 
echo "Building report, you may want to grab a Snickers..." 
 
for line in $(cat $filename) ; do     
    nmap $line --top-ports 25 -O > results.txt     
    echo "Report for" $line "follows." >> report.txt 
    phys_address=$(cat results.txt | grep MAC | cut -d" " -f3) 
    os=$(cat results.txt | grep Running) 
    hname=$(cat results.txt | grep report | cut -d" " -f5) 
    open=$(cat results.txt | grep open | awk {'print $1,$3'}) 
    echo "Physical address is" $phys_address >> report.txt 
    echo $os >> report.txt 
    echo "Hostname is" $hname >> report.txt 
    echo "Open ports are" $open >> report.txt 
     
    if [[ $(cat results.txt | grep 'Running' | cut -d" " -f2) = 'Cisco' ]] ; then 
    echo $line IS a network device************ >> report.txt 
    fi     
 
    echo >> report.txt 
    echo 
    echo $line complete. "Still goin'." 
 
done 
 
echo "Complete!" 
 
exit 
