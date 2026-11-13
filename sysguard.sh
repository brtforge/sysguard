#!/bin/bash

# SYSTEM INFORMATION

OS=$(grep PRETTY_NAME /etc/os-release | cut -d '=' -f2 | tr -d '"')
HOSTNAME=$(hostname)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)


# CPU INFORMATION

CPU_MODEL=$(lscpu | grep "Model name" | cut -d ':' -f2 | xargs)
CPU_ARCHITECTURE=$(lscpu | grep "^Architecture:" | cut -d ':' -f2 | xargs)
CPU_COUNT=$(nproc)
CPU_HYPERVISOR=$(lscpu | grep "^Hypervisor" | cut -d ':' -f2 | xargs)


# MEMORY INFORMATION

RAM_TOTAL=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
RAM_FREE=$(awk '/^MemFree:/ {print $2}' /proc/meminfo)
RAM_AVAILABLE=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

SWAP_TOTAL=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
SWAP_FREE=$(awk '/^SwapFree:/ {print $2}' /proc/meminfo)

RAM_USED=$((RAM_TOTAL - RAM_AVAILABLE))
SWAP_USED=$((SWAP_TOTAL - SWAP_FREE))

RAM_USAGE_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))

RAM_TOTAL_MB=$((RAM_TOTAL / 1024))
RAM_USED_MB=$((RAM_USED / 1024))
RAM_AVAILABLE_MB=$((RAM_AVAILABLE / 1024))


# PROCESS INFORMATION

PROCESS_DATA=$(ps -e -o pid,user,%cpu,%mem,comm)

TOP_CPU=$(
    {
        echo "$PROCESS_DATA" | head -n 1
        echo "$PROCESS_DATA" | tail -n +2 | sort -k3,3nr | head -n 5
    }
)

TOP_MEMORY=$(
    {
        echo "$PROCESS_DATA" | head -n 1
        echo "$PROCESS_DATA" | tail -n +2 | sort -k4,4nr | head -n 5
    }
)


# REPORT CONFIGURATION

SEPARATOR="===================================================="
SUB_SEPARATOR="----------------------------------------------------"

# GENERATE SYSTEM REPORT

echo "$SEPARATOR"
echo "              SYSGUARD SYSTEM REPORT"
echo "$SEPARATOR"
echo

echo "SYSTEM INFORMATION"
echo "$SEPARATOR"
echo "Operating System: $OS"
echo "System Hostname: $HOSTNAME"
echo "Kernel: $KERNEL"
echo "System Uptime: $UPTIME"
echo

echo "CPU INFORMATION"
echo "$SEPARATOR"
echo "CPU Model: $CPU_MODEL"
echo "CPU Architecture: $CPU_ARCHITECTURE"
echo "Available CPU Units: $CPU_COUNT"
echo "Hypervisor: ${CPU_HYPERVISOR:-None detected}"
echo

echo "MEMORY INFORMATION"
echo "$SEPARATOR"
echo "Total RAM: ${RAM_TOTAL_MB} MiB"
echo "Used RAM: ${RAM_USED_MB} MiB (${RAM_USAGE_PERCENT}%)"
echo "Available RAM: ${RAM_AVAILABLE_MB} MiB"
echo "Free RAM: $((RAM_FREE / 1024)) MiB"
echo
echo "Total Swap: $((SWAP_TOTAL / 1024)) MiB"
echo "Used Swap: $((SWAP_USED / 1024)) MiB"
echo "Free Swap: $((SWAP_FREE / 1024)) MiB"
echo

echo "PROCESS INFORMATION"
echo "$SEPARATOR"
echo

echo "TOP 5 PROCESSES BY CPU USAGE"
echo "$SUB_SEPARATOR"
echo "$TOP_CPU"
echo

echo "TOP 5 PROCESSES BY MEMORY USAGE"
echo "$SUB_SEPARATOR"
echo "$TOP_MEMORY"
echo
echo "$SEPARATOR"
