#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.


#!/bin/bash

#This script accepts a text file with raw IPs in individual lines and then performs chosen nmap enumeration tasks against the hosts listed in the file.


#User enters name of file to use as the list of IPs to enumerate against.

echo "Please enter filename to use. File should be a clean list of IPs, delimited with carriage returns." 
read -e filename

#Input validation

	if [ ! -f $filename ]; then
		echo "Bad filename. Closing program."
		exit
	fi

#User names a file to save results to.
echo "Please name your results file."
read -e savefile

#Function selection

echo
echo "Now tell us what you want to do. Here are your choices:"
echo "Enter 1 for a basic top port nmap scan."
echo "Enter 2 for nmap OS enumeration."
read -e action

	if [ $action -eq 1 ]; then
		echo "How many ports? Please enter integer:"
		read -e ports
		echo "Scanning" $ports "top ports against" $filename "at" date >> $savefile.txt
		echo
		echo
 		for i in $(cat $filename); do
		echo $i >> $savefile.txt
		nmap --top-ports $ports $i >> $savefile.txt
		done

	elif [ $action -eq 2 ]; then
		echo "Scanning for operating systems against " $filename " at " date >> $savefile.txt
		echo
		echo
		for i in $(cat $filename); do
		echo $i >> $savefile.txt
		nmap -O $i >> $savefile.txt
		done

	else
		echo "You entered an invalid option. Goodbye."
		exit

	fi

#Gives user the option to view results while still in the program.

echo "Would you like to view your results?"
echo "Enter 1 for yes and 2 for no."
read -e response1

	if [ $response1 -eq 1 ]; then
		cat $savefile.txt
		exit

	elif [ $response1 -eq 2 ]; then
		updatedb
		location=$(locate $savefile.txt)
		echo "Process complete. Your results have been saved to: $location"
		echo "Closing program. Thank you." 
		exit

	else
		echo "You entered an incorrect response."
		updatedb
		location=$(locate $savefile.txt)
		echo "Process complete. Your results have been saved to: $location"
		echo "Closing program. Thank you."
		exit

	fi
