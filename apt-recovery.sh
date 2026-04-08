#!/bin/bash
set -euo pipefail

# ==========================================
# APT Package Recovery Toolkit
# Repository: https://github.com/NiteeshPujari/apt-package-recovery-toolkit
# Author: Pujari Niteesh
# ==========================================

# ==========================================
# Variables & Colors
# ==========================================
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
LOG_FILE="/var/log/apt-repair.log"

# Trap errors to notify the user
trap 'echo -e "${RED}[!] An error occurred during execution. Please check the log: $LOG_FILE${NC}"' ERR

# ==========================================
# TODO / Roadmap
# ==========================================
# [x] Distro auto-detection
# [ ] Dry-run mode
# [ ] Backup & rollback
# [ ] Interactive menu UI

# ==========================================
# Functions
# ==========================================

# Print status to terminal and append to log file
log_message() {
    echo -e "${CYAN}[*] $1${NC}"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Ensure the script is run with root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}[!] Error: This script must be run as root. Please use sudo.${NC}"
        exit 1
    fi
}

# Ensure the system actually uses APT
check_distro() {
    if ! command -v apt-get >/dev/null; then
        echo -e "${RED}[!] Unsupported system: APT not found.${NC}"
        exit 1
    fi
}

kill_apt_processes() {
    log_message "Checking for running APT processes..."

    if pgrep -f 'apt|apt-get|dpkg|unattended-upgrade|packagekit' >/dev/null; then
        echo -e "${YELLOW}[!] Warning: APT/DPKG process is currently running.${NC}"
        read -p "Do you want to terminate it? (y/N): " choice

        if [[ "$choice" =~ ^[Yy]$ ]]; then
            pkill -15 -f 'apt|apt-get|dpkg' 2>/dev/null || true
            sleep 3
            pkill -9 -f 'apt|apt-get|dpkg' 2>/dev/null || true
            log_message "APT processes terminated."
        else
            log_message "Skipping process termination."
        fi
    else
        log_message "No active APT processes found."
    fi
}

remove_locks() {
    log_message "Checking and removing stale lock files..."

    if ! pgrep -f 'apt|apt-get|dpkg|unattended-upgrade|packagekit' >/dev/null; then
        rm -f /var/lib/dpkg/lock-frontend \
              /var/lib/dpkg/lock \
              /var/lib/apt/lists/lock \
              /var/cache/apt/archives/lock 2>/dev/null || true
        log_message "Stale lock files removed."
    else
        log_message "Skipping lock removal because APT is active."
    fi
}

configure_dpkg() {
    log_message "Auditing and configuring packages..."
    dpkg --audit >> "$LOG_FILE" 2>&1
    dpkg --configure -a >> "$LOG_FILE" 2>&1
}

fix_broken_deps() {
    log_message "Fixing broken dependencies..."
    apt-get --fix-broken install -y >> "$LOG_FILE" 2>&1
}

cleanup_packages() {
    log_message "Cleaning package cache..."
    apt-get clean >> "$LOG_FILE" 2>&1
    apt-get autoremove -y >> "$LOG_FILE" 2>&1
}

update_and_upgrade() {
    log_message "Updating repositories and upgrading system..."
    apt-get update >> "$LOG_FILE" 2>&1
    apt-get full-upgrade -y >> "$LOG_FILE" 2>&1
}

display_fastfetch() {
    if ! command -v fastfetch &> /dev/null; then
        log_message "Installing fastfetch..."
        apt-get install fastfetch -y >> "$LOG_FILE" 2>&1 || true
    fi
    echo -e "\n"
    fastfetch || true
    echo -e "\n"
}

print_quote() {
    quotes=(
        "Linux: Freedom to choose!"
        "Linux: Power at your fingertips!"
        "Linux: Where coders feel at home."
        "Linux: Stability meets flexibility."
        "Linux: Open-source, Open Possibilities."
    )
    local random_index=$((RANDOM % ${#quotes[@]}))
    echo -e "${YELLOW}=========================================${NC}"
    echo -e "${GREEN}${quotes[$random_index]}${NC}" 
    echo -e "${YELLOW}=========================================${NC}\n"
}

# ==========================================
# Main Execution Flow
# ==========================================
main() {
    clear
    echo -e "${GREEN}Starting APT Package Recovery Toolkit...${NC}\n"
    
    check_root
    check_distro
    
    # Initialize/Append the log file for this run
    echo -e "\n--- APT Repair Log Started at $(date) ---" >> "$LOG_FILE"

    kill_apt_processes
    remove_locks
    configure_dpkg
    fix_broken_deps
    cleanup_packages
    update_and_upgrade
    
    display_fastfetch
    
    echo -e "${GREEN}[✔] Package recovery completed successfully! (Check $LOG_FILE for details)${NC}\n"
    print_quote
    echo -e "Scripted By Pujari Niteesh"
}

# Run the main function
main
