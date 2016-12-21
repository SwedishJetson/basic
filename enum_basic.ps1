#This is a simple Powershell script that enumerates basic system and file information on a host.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.
 
#process information:  
gwmi win32_process | select name, processid, parentprocessid | sort parentprocessid  
#Get-process  
 
#Directory information:  
Get-childitem c:\windows | select name, mode, lastwritetime | sort lastwritetime  
#File Information:  
$EnumUsers = @{}  
    foreach ($User in (Get-childitem c:\users | select-object Name)){  
        get-childitem >> c:\Users\<username>\EnumUsers.txt  
     }  
#System configuration information:  
systeminfo  
#Network Information:  
Netstat -naobv 
