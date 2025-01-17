#!/bin/bash

Geoip=$(apt list --installed 2>/dev/null | grep geoip-bin | awk -F/  '{print $1}') 
if [[ "$Geoip" == "geoip-bin" ]]
then

echo '[#] geopip-bin is already installed'
else 

function repeatgeoip()
{

read -p "[?] would you like to install geoip-bin [y/n] " Userchoice


case $Userchoice in
	y|Y)
		sudo apt install geoip-bin -y > /dev/null 2>&1
		echo '[#] Geoip-bin has been installed'
	
	;;
	n|N)
	
		echo '[!] aborting service good bye'
		
	;;
	*) 
	
		echo '[?] that was not one of the options please select y or n' 
		repeatgeoip
	;;
	esac 

}
 
repeatgeoip
fi


Tor=$(apt list --installed 2>/dev/null | grep -w tor | grep -v geoip  | awk -F/kali  '{print $1}') 

if [[ "$Tor" == "tor" ]] 
then
echo '[#] tor is already installed'
else 
function repeattor() 

{
read -p "[?] would you like to install tor [y/n] " Torchoice 


case $Torchoice in
	y|Y)
		sudo apt install -y tor > /dev/null 2>&1
		echo '[#] tor has been installed' 
	;;
	n|N)
		echo '[!] aborting service good bye'
		
	;;
	*) 
		echo '[?] That was not one of the options please select y or n' 
		repeattor
	;;
 
	esac
}
repeattor  
fi


function NIPEINSTALLER()
{
		git clone https://github.com/htrgouvea/nipe > /dev/null 2>&1  && cd nipe 
		cpanm --installdeps . > /dev/null 2>&1 	                                   
		sudo cpan install Config::Simple > /dev/null 2>&1
		sudo perl nipe.pl install > /dev/null 2>&1
}


function NIPECHOICE()
{
read -p "[?] would you like to install nipe? [y/n] " Userchoice 


case $Userchoice in
	y|Y)
		echo '[#] installing nipe' 
		NIPEINSTALLER
		NIPEchecker
		
	;;
	n|N)
		echo '[!] The script will not be able to run effectively without nipe'
		
	;;
	*) 
		echo '[?] that was not one of the options please select y or n' 
		repeatnipe
	;;
	esac
}

function NIPEDELETER()
{
	echo "[!] Deleting compromised files"
	sudo rm -rf $Directory	

}


function NIPEchecker()
{

Nipefolder=$(find / -type d -name nipe 2>/dev/null | grep -o nipe) 
Directory=$(find / type -d -name nipe 2>/dev/null) 
if [[ "$Nipefolder" == "nipe" ]]
then
	NIPEMD5=$(cd $Directory && md5sum nipe.pl | awk '{print $1}')
	if [[ "$NIPEMD5" == "20e51fa0b07e57333d30d5d38dba7033" ]] 
	then
	echo "[*] Nipe has been successfully installed"
	else
	echo "[!] Nipe was not installed correctly"
	echo "[*] Restarting installation"
	NIPEDELETER
	echo "[*] Reinstalling file"
	NIPEINSTALLER
	NIPEchecker
	fi
else
NIPECHOICE
fi
}
NIPEchecker

function STARTER()
{
Directory=$(find / type -d -name nipe 2>/dev/null) 
echo '[!] starting nipe'
echo 
cd $Directory && sudo perl nipe.pl stop
cd $Directory && sudo perl nipe.pl start 
Status=$(cd $Directory && sudo perl nipe.pl status | grep -o true)

if [[ "$Status" == "true" ]]
then
Spoofedip=$(cd $Directory && sudo perl nipe.pl status | grep [0-9] | awk -F: '{print $2}') 
country=$(geoiplookup $Spoofedip | awk '{print $(NF)}') 
echo "[#] your connection is anonymous, you are connected to a remote server"
echo "[#] your spoofed ip address is $Spoofedip and your spoofed country is $country"
echo
else
STARTER
fi
}
STARTER





#2nd part
	read -p "Enter the IP address of the server you wish to connect to via SSH: " SERVERIP
	read -p "Enter the Username you wish to log in as: " SERVERUSERNAME
function serverinfo()
{	
	echo [#} Displaying server information
	ssh tc@192.168.155.131 "echo 'The currentuser is:'; whoami; echo 'The current directory is:'; pwd; echo 'The external ip address of the server is:'; curl ifconfig.io" 2>/dev/null
}		



function Scandomain()
{
echo
read -p "[?] Specify a domain or ip address to scan: " Scanip 
echo [!] Scanning domain/ip address
ssh $SERVERUSERNAME@$SERVERIP "nmap $Scanip >> /home/$SERVERUSERNAME/nmap_$Scanip" #directory can be changed but this is the directory of my server, flags can be added as well depending on what type of scan you want
#echo stuff and retrieve via scp 

}


function Repeatscan() 
{
	
read -p '[?] Do you wish to scan another domain or ip address ? [y/n] :' Rescan 
case $Rescan in 

	y|Y)
		Scandomain 
		Repeatscan
		
	;;
	n|N)
		echo  
		
		
	;;
	*)
		echo '[!] That was not one of the options please select [y/n]' 
		Repeatscan
	;;
esac
}


function Whoiser() 
{	
	echo 
	read -p '[?] Specify a domain or ip address to Whois: ' Whoisip 
	echo [!] whoising domain/ip address 
	ssh $SERVERUSERNAME@$SERVERIP "whois $Whoisip >> whois_$Whoisip" 
	 }


function Repeatwhois() 
{
	read -p '[?] Do you wish to whois another domain or ip address ? [y/n] :' Rewhois 
	case $Rewhois in 

	y|Y)
		Whoiser 
		Repeatwhois
		
	;;
	n|N)
		echo  
		
		
	;;
	*)
		echo '[!] That was not one of the options please select [y/n]' 
		Repeatwhois
	;;
	esac
}
serverinfo 
Whoiser
Scandomain
Repeatwhois
Repeatscan



function RETRIEVER()
{
read -p "[?] On which directory on your local machine do you wish to store your scans: " SAVEDIR
read -p "[?] Is $SAVEDIR the correct file path?[Y/N]: " CONFIRMDIR
case $CONFIRMDIR in

y|Y)
echo "[*] Retrieving whois results from remote machine"
scp $SERVERUSERNAME@$SERVERIP:/home/$SERVERUSERNAME/whois_$Whoisip $SAVEDIR
echo "[*] Retrieving nmap scans from remote machine"
scp $SERVERUSERNAME@$SERVERIP:/home/$SERVERUSERNAME/nmap_$Scanip $SAVEDIR
;;
n|N)
RETRIEVER
;;

*)
echo "[!] That response is not recognised please select either [Y/N]: "
;;
esac
}
RETRIEVER






















