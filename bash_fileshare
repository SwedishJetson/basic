#This is a bash script used to create and share directories then define permissions to predetermined users on those directories and their files.

#Do not run this program on or against a host for which you are not the administrator!
#If you don't understand what this script does, then you shouldn't be running it. Go back and do some research first!
#Respect people's privacy!
#Run all scripts responsibly!
#The author of this script assumes ZERO responsibility for harm caused to systems on which this script is run.
#The author of this script assumes ZERO responsibility for any punitive damages that befall you because you didn't read/heed the above.

#!/bin/bash 

mkdir /smb_share 
echo "/smb_share directory added." 
ls / 
echo 
sleep 1 
 
#Gives read, write, and execute permissions to the owner and group, with no permissions to "other". 
chmod 770 /smb_share 
echo "Gave read, write, and execute permissions to the owner and group, with no permissions to other." 
ls -l / 
echo 
sleep 1 
 
#Creates three files within the /cctcsmb shared directory. 
touch /smb_share/file1 
touch /smb_share/file2 
touch /smb_share/file3 
echo "Created three files within the /smb_share shared directory." 
ls /smb_share 
echo 
sleep 1 
 
#Creates the user "sam". 
useradd sam
echo "New user, samc added." 
cat /etc/passwd | grep sam 
echo 
sleep 1 
 
#Creates the group "smbusers" 
groupadd smbusers 
echo "New group, smbusers added." 
echo 
sleep 1 
 
#Adds the user "sam" to the group "sambausers" 
usermod -a -G smbusers sam
echo "User sam added to the group smbusers." 
echo 
sleep 1 
 
#Gives ownership of the /smb_share to the user "sam". 
chown sam /smb_share
echo "Gave ownership of the /smb_sahre to the user sam." 
ls -l / | grep smb_share
echo 
sleep 1 
 
#Configures the smb.conf file with the share definitions so that smb.conf allows guest access, is not read only, and can also be browsed. 
echo '[smb_share]' >> /etc/samba/smb.conf 
echo '[path] = /smb_share' >> /etc/samba/smb.conf 
echo 'guest ok = yes' >> /etc/samba/smb.conf 
echo 'read only = no' >> /etc/samba/smb.conf 
echo 'browseable = yes' >> /etc/samba/smb.conf 
echo "Configured the smb.conf file with the share definitions so that smb.conf allows guest access, is not read only, and can also be browsed." 
cat /etc/samba/smb.conf | grep smb_share -C 5 
echo 
sleep 1 
 
#Restarts the samba service. 
service smbd restart 
echo "smbd service restarted" 
service smbd status | grep smbd.service -C 2 
echo "Complete."
