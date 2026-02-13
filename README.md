# Sanuu Command Tool

This is a simple utility script I wrote for Arch Linux to help manage system performance and keep things clean.

## What does it do?

It helps you control your computer's power modes and clean up junk files.

### Power Profiles
It looks at what your computer's motherboard (BIOS) supports and lets you switch between modes easily.

For example, if your system supports these modes, you can run:
- `sanuu light` - Good for saving battery.
- `sanuu balance` - Good for daily use.
- `sanuu power` - Good for gaming or heavy tasks.

It will automatically check which profiles your computer actually has. You can see the full list by running `sanuu profiles`.

### System Cleaning
It can also clean up your system.

- `sanuu clean` - This does a standard cleanup. It clears out old package caches (pacman), helper caches (yay/paru), removes orphaned packages that nothing uses anymore, and trims system logs.
- `sanuu deepclean` - This does everything above, plus it clears out thumbnail caches, emptying the trash, and safely removing temporary files that are more than a day old.

When it finishes cleaning, it will tell you exactly how much space was recovered.

## How to Install

1. Download or clone this repository.
2. Open a terminal in this folder.
3. Run `./install.sh`

The installer will verify everything and show you which power profiles are available on your specific machine.

## How to Uninstall

If you want to remove it, just run `./uninstall.sh` and it will remove all traces of the tool from your system.
