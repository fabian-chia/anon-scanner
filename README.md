# anon-scanner

Anonymously scans an IP address or domain of your choice

Function 1
- Checks if the necessary packages are already installed
- Packages include; nipe, tor, gepip-bin
  
![Image](https://github.com/user-attachments/assets/d4aab621-e309-49c0-9030-0af66a9c2d6d)

Function 2
- starts nipe to make the machine untraceable
- confirms and informs the user that the machine has spoofed another ip address
- tells the user what the spoofed ip address is

![Image](https://github.com/user-attachments/assets/20412161-2ff0-4c7a-a7c0-530c1bf93249)

Function 3
-  Logging in to a remote server via ssh
-  The server needs to be your own and you are required to have the login credentials of the server
- Results will then be stored in the server and retrieved afterwards

![Image](https://github.com/user-attachments/assets/f58aecbb-2681-418a-929b-8d1c040401c1)

Function 4
- Uses the whois package to check for any domain or ip of your choice and stores the results into the remote server

![Image](https://github.com/user-attachments/assets/900d72cd-7a28-4d3a-8093-335d9b19a1c2)

Function 5
- conducts a simple nmap scan of any Ip address of your choice and stores it into the remote server
- The nmap scan conducted is configured to be a basic nmap scan which can be modified after downloading
  
![Image](https://github.com/user-attachments/assets/a60cd2e7-07e4-4312-aba3-f639a6327e55)

Function 6
- The script will prompt the user if the user wants to conduct another whois/nmap scan
  
![Image](https://github.com/user-attachments/assets/eaa0f5b6-3105-4626-b9e1-2b620fdf0920)

Function 7
- The script will retrieve all results and store it into the directory of your choice via scp
  
![Image](https://github.com/user-attachments/assets/87b2af04-7d9b-4ecd-8f48-a21a3b59cef0)

Results
- The image below shows that the scans are saved in the directory specified above
  
![Image](https://github.com/user-attachments/assets/87b2af04-7d9b-4ecd-8f48-a21a3b59cef0)
