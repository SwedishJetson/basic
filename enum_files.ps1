#This is a Powershell script written to quickly enumerate some basic file information from a remote system.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#connect to remote system: 
 
Enter-PSSession -ComputerName <remote host> 
 
#system date and time:  
 
get-date > C:\users\ieuser\desktop\results.txt 
     
#system configuration information:  
 
systeminfo >> C:\users\ieuser\desktop\results.txt  
 
#logged on users:  
 
query user /server 127.0.0.1 >> C:\users\ieuser\desktop\results.txt 
     
#network sessions: - netstat –na >> C:\users\ieuser\desktop\results.txt 
 
     
#open files:  
 
Openfiles /query /S 127.0.0.1 >> C:\users\ieuser\desktop\results.txt 
     
#current running processes: 
 
Get-process >> C:\users\ieuser\desktop\results.txt 
 
#DLLs loaded into processes: 
 
Get-process | where {$_.modules -like '*(*.dll)'} >> C:\users\ieuser\desktop\results.txt 
 
#mapped drives: 
 
Get-psdrive >> C:\users\ieuser\desktop\results.txt 
     
#configured devices: 
 
Get-PSDrive >> C:\users\ieuser\desktop\results.txt 
[System.IO.DriveInfo]::getdrives() >> C:\users\ieuser\desktop\results.txt 
wmic diskdrive >> C:\users\ieuser\desktop\results.txt 
wmic volume >> C:\users\ieuser\desktop\results.txt 
     
#shared resources: 
 
get-wmiobject win32_share >> C:\users\ieuser\desktop\results.txt 
