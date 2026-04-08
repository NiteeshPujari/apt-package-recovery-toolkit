# 🛠️ APT Package Recovery Toolkit

<p align="center">
  Safe Bash toolkit to repair broken APT/DPKG packages, stale locks, and dependency issues on Debian-based Linux systems.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Bash-Script-green" alt="Bash">
  <img src="https://img.shields.io/badge/Linux-Debian%20Based-blue" alt="Platform">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
  <img src="https://img.shields.io/badge/Status-Stable-success" alt="Status">
</p>

---

## ✨ Features

- ✅ **Safe Process Detection** — Checks for active APT processes before terminating hanging jobs
- ✅ **Stale Lock Cleanup** — Detects and removes only stale lock files safely
- ✅ **DPKG Recovery** — Audits and configures broken package states
- ✅ **Dependency Repair** — Repairs broken dependencies using `apt-get --fix-broken install`
- ✅ **Package Cache Cleanup** — Cleans package cache using `apt-get clean` and removes unused packages with `autoremove`
- ✅ **System Upgrade** — Runs a full system upgrade safely
- ✅ **Detailed Logging** — Maintains recovery logs at `/var/log/apt-repair.log` for troubleshooting
- ✅ **Modern UI** — Displays clean terminal output and system stats using Fastfetch

---

## ⚠️ Safety Notice

This script is designed for **Debian-based Linux distributions** and should be run only when APT or DPKG is in a broken or interrupted state.

**Key Safety Features:**
- Performs safe checks before removing lock files or terminating package processes
- Does not forcefully kill active package managers unless explicitly confirmed by the user
- Reduces the risk of package database corruption

**Avoid running this script while:**
- System updates are already in progress
- GUI Software Center / Discover is open
- Automatic unattended upgrades are running

---

## 📦 Supported Linux Distributions

This script supports Debian-based distributions using APT, including:

- Kali Linux
- Debian
- Ubuntu
- Linux Mint
- POP!_OS
- Parrot OS
- MX Linux
- Devuan
- Sparky Linux
- antiX

### ❌ Unsupported Systems

This script is **not compatible** with:

- Arch Linux / Manjaro (pacman)
- Fedora / RHEL (dnf)
- CentOS / older RHEL (yum)
- openSUSE (zypper)

---

## 🚀 Installation & Usage

### 1. Clone the Repository

```bash
git clone https://github.com/NiteeshPujari/apt-package-recovery-toolkit.git
cd apt-package-recovery-toolkit
chmod +x apt-recovery.sh
```

### 2. Run the Script

```bash
sudo ./apt-recovery.sh
```

---

## 📂 What This Script Does — Step by Step

| Step | Action | Command |
|------|--------|---------|
| 1️⃣ | Check root privileges | Ensures sudo or root access |
| 2️⃣ | Check for active APT processes | Detects running package manager instances |
| 3️⃣ | Remove stale lock files | Safely deletes locks when no manager is active |
| 4️⃣ | Audit and reconfigure packages | `dpkg --audit` & `dpkg --configure -a` |
| 5️⃣ | Repair broken dependencies | `apt-get --fix-broken install` |
| 6️⃣ | Clean package cache | `apt-get clean` & `apt-get autoremove` |
| 7️⃣ | Update system packages | `apt-get update` & `apt-get full-upgrade` |
| 8️⃣ | Display system information | Shows hardware and OS info using Fastfetch |

---

## 🩹 Common Issues This Script Fixes

- ❌ `dpkg was interrupted`
- ❌ `Could not get lock /var/lib/dpkg/lock-frontend`
- ❌ `Unmet dependencies`
- ❌ `Broken packages`
- ❌ `Sub-process /usr/bin/dpkg returned an error code`
- ❌ `Interrupted package installations`

---

## 📷 Example Output

```
Starting APT Package Recovery Toolkit...

[*] Checking for running APT processes...
[*] Checking and removing stale lock files...
[*] Auditing and configuring packages...
[*] Fixing broken dependencies...
[*] Cleaning package cache...
[*] Updating repositories and upgrading system...

<fastfetch system info here>

[✔] Package recovery completed successfully! 
(Check /var/log/apt-repair.log for details)

=========================================
Linux: Where coders feel at home.
=========================================
```

---

## 🏷️ Recommended GitHub Topics

Add these tags in your repository settings for better discoverability:

`bash` • `linux` • `apt` • `dpkg` • `ubuntu` • `debian` • `package-repair` • `linux-tools` • `sysadmin` • `automation`

---

## 👨‍💻 Author

**Pujari Niteesh**  
Cyber Security Research Engineer | CTF Challenge Developer | Red Team / Blue Team Research

- 🔗 **GitHub:** [@NiteeshPujari](https://github.com/NiteeshPujari)
- 🌐 **Website:** [www.niteesh.in](https://www.niteesh.in)
- 📜 **Skills:** MTA Scripter • Linux Learner 🐧 • Python • SQL • Bash

---

## 📝 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

<p align="center">
  <strong>Made with ❤️ for the Linux community</strong>
</p>
