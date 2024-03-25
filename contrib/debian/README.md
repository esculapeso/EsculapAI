
Debian
====================
This directory contains files used to package esad/esa-qt
for Debian-based Linux systems. If you compile esad/esa-qt yourself, there are some useful files here.

## esa: URI support ##


esa-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install esa-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your esa-qt binary to `/usr/bin`
and the `../../share/pixmaps/esa128.png` to `/usr/share/pixmaps`

esa-qt.protocol (KDE)

