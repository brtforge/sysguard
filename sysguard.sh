#!/bin/bash

OS=$(grep PRETTY_NAME /etc/os-release | cut -d '=' -f2 | tr -d '"')

HOSTNAME=$(hostname)

KERNEL=$(uname -r)

UPTIME=$(uptime -p)

CPU_MODEL=$(lscpu | grep "Model name" | cut -d ':' -f2 | xargs)

CPU_ARCHITECTURE=$(lscpu | grep "^Architecture:" | cut -d ':' -f2 | xargs)

CPU_COUNT=$(nproc)

CPU_HYPERVISOR=$(lscpu | grep "^Hypervisor" | cut -d ':' -f2 | xargs)

SEPARATOR="===================================================="


echo "$SEPARATOR"
echo "              SYSGUARD SYSTEM REPORT"
echo "$SEPARATOR"
echo

echo "Operating System: $OS"

echo "System Hostname: $HOSTNAME"

echo "Kernel: $KERNEL"

echo "System Uptime: $UPTIME"

echo "CPU Model: $CPU_MODEL"

echo "CPU Architecture: $CPU_ARCHITECTURE"

echo "Available CPU Units: $CPU_COUNT"

echo "Hypervisor: ${CPU_HYPERVISOR:-None detected}"
echo

echo "$SEPARATOR"
