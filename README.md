# Sanuu Command Tool 🚀

A powerful, all-in-one utility script for Arch Linux to manage performance, maintain system health, and keep storage lean.

## ✨ Features

### 🛠️ System Maintenance
- **`sanuu clean`**: Standard cleanup. Clears old package caches (keeps 2 versions), AUR helper caches, and orphans.
- **`sanuu deepclean`**: Everything in `clean` plus thumbnails, trash, and temporary files.
- **`sanuu optmirror`**: Automatically finds the 10 fastest HTTPS mirrors in your country using `reflector`.
- **`sanuu systemupdate`**: Unified update for official repositories, AUR packages (`yay`/`paru`), and Flatpaks.
- **`sanuu checkpackageupdates`**: Safe preview of all pending updates without installing them.

### 📊 Health & Monitoring
- **`sanuu health`**: A clean dashboard showing failed services, disk usage, and CPU temperature.
- **`sanuu battery`**: Detailed life and health report for laptops (charge, health %, wattage, and cycles).
- **`sanuu spec`**: Animated terminal spec deck for VRAM, RAM, and available storage.

### ⚡ Performance & Apps
- **`sanuu profiles`**: Lists available ACPI power profiles (Performance, Balanced, Power-Saving).
- **`sanuu <profile_name>`**: Switch power profiles instantly.
- **`sanuu spotify`**: Install/Update SpotX (Spotify Adblocker).
- **`sanuu antigravity`**: Install/Update the latest binary releases of Antigravity.

---

## 📦 How to Install

Run this one-line command to get started:
```bash
git clone https://github.com/Sanuu7/archzshutils.git && cd archzshutils && ./install.sh
```

The installer handles all dependencies (like `pacman-contrib`) and verifies your hardware support.

## 🗑️ How to Uninstall

Run the uninstaller from the repository:
```bash
./uninstall.sh
```
It will safely remove the tool and optionally clean up the dependencies it installed.

---
*Created with ❤️ for Arch Linux users.*
