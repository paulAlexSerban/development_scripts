#!/bin/bash

function get-sysinfo() {
    echo "System Information" >/tmp/sysinfo.txt
    echo "Date: $(date)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "Hostname: $(hostname)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "Kernel Version: $(uname -r)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "Uptime: $(uptime)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "File System: $(df -h)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "Network Configuration: $(ifconfig)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "Environment Variables: $(printenv)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt
    echo "DNS Servers: $(cat /etc/resolv.conf | grep nameserver)" >>/tmp/sysinfo.txt
    echo "--------------------------------------------------------------------------------" >>/tmp/sysinfo.txt

    code /tmp/sysinfo.txt
}

echo "${GREEN}--- sysinfo scripts loaded${NC}"
echo "         available commands: get-sysinfo"
