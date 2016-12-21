#This is piece one of a two piece bash script that can be used to parse through text-based NMAP results (nmap_results.txt).
#The purpose is to quickly and cleanly see the services that are being run on a network.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash 
 
#Adds 22 lines of empty space between the instances of the string VMware on the document NMAP_results.txt and saves the changes as NMAP_results_spaced.txt
#This is necessary to prevent parsing actions from stepping through the results of multiple hosts within the .txt file.
 
sed '/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;/(VMware)/G;' NMAP_all_hosts.txt > NMAP_hosts_spaced.txt 
 
sleep 3 
 
#Build a list of all the protocols listed in the report. In this list, the protocols are not counted. 
 
cat NMAP_results_spaced.txt | grep "open" | grep -v "OSScan" | sort | cut -d"/" -f2 | column -t | cut -d" " -f5 | sort | uniq > protocols 
 
sleep 5 
 
#Use the new, spaced out file and echo the output of cat && NMAP_results_spaced.txt into a pipe and grep for the string open. 
#Pipe those results into a grep -v for "OSScan". Sort those results, and use the cut command with the "/" character as the delimiter 
#and display the second field. Pipe that into a column -t command and pipe those into another cut, using the empty space as the
#delimiter and displaying the fifth field. Finally, perform a | sort | unique -c and pipe that into a | sort -nr to see things in 
#reverse numerical order. This will enumerate the open services across the report and tell you how many times each one occurs in 
#order of frequency. Sends the results to a file called results.txt. 
 
echo && cat NMAP_hosts_spaced.txt | grep "open" | grep -v "OSScan" | sort | cut -d"/" -f2 | column -t | cut -d" " -f5 | sort | uniq -c | sort -nr 
 
sleep 2 
 
#runs the program getresults.sh (piece two of two) against the files protocols and NMAP_all_hosts and sends the results to the file report.txt 
./nmap_parser2.sh protocols NMAP_results.txt > report.txt 
 
echo Report created! 
echo "Please review the results of this program by opening the file report.txt." 
echo "Complete." 
