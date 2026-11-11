#!/bin/bash

OS=$(grep PRETTY_NAME /etc/os-release | cut -d '=' -f2 | tr -d '"')

HOSTNAME=$(hostname)

KERNEL=$(uname -r)

UPTIME=$(uptime -p)

SEPARATOR="===================================================="


echo "$SEPARATOR"
echo "              SYSGUARD SYSTEM REPORT"
echo "$SEPARATOR"
echo

echo "Operating System: $OS"

echo "System Hostname: $HOSTNAME"

echo "Kernel: $KERNEL"

echo "System Uptime: $UPTIME"
echo

echo "$SEPARATOR"
