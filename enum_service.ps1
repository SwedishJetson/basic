#This is a Powershell script that enumerates services on a Windows machine.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.
 
$Readout1 = Read-Host "Welcome to SwedishJetson's Service Enumeration Tool. Press <enter> to build a list of running processes." 
 
#$Readout2 = Read-Host "Building your list of running processes" 
 
& gps | select ProcessName, Handles, npm, vm, sessionid, path 
 
$Process = Read-Host -Prompt "Please enter a process name to enumerate from the list above." 
 
& C:\Windows\System32\SysInternalsSuite\listdlls.exe $Process 
