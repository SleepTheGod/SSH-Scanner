  █████████   █████████  █████   █████     
 ███░░░░░███ ███░░░░░███░░███   ░░███   
░███    ░░░ ░███    ░░░  ░███    ░███    
░░█████████ ░░█████████  ░███████████      
 ░░░░░░░░███ ░░░░░░░░███ ░███░░░░░███     
 ███    ░███ ███    ░███ ░███    ░███     
░░█████████ ░░█████████  █████   █████  
 ░░░░░░░░░   ░░░░░░░░░  ░░░░░   ░░░░░ 

How To Install The Scanner !

1. Open terminal on linux and type the following git clone https://github.com/SleepTheGod/SSH-Scanner/

2. Next we are going to type chmod +x SSH-Scanner

3. Now we type the following cd SSH-Scanner

4. Then we are going to type chmod +x main.sh

5. Now we type ./main.sh then you type sudo mv scanner.sh /usr/local/bin/scanner

6. Now you are done you can use this tool now by typing scanner --help


Usage
scanner --help
scanner <IP range> -p <port> -t <timeout>

Explanation
The script starts by setting default values for the SSH port, timeout, user list, and password list URL.
It defines a function to download the password list if it doesn't already exist.
It includes a usage function to display help messages.
The script checks for the necessary tools (hydra and nmap).
It parses command-line options for customizing the SSH port and timeout.
The script scans the given IP range for open SSH ports using nmap.
It then uses hydra to attempt brute-force SSH login on each open host.
This script ensures a more comprehensive and automated approach to scanning an IP range and attempting SSH brute-force attacks.
