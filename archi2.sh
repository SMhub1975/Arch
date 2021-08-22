#!/bin/bash

echo "arch" >> /etc/hostname
echo "LANG=es_AR.UTF-8" >> /etc/locale.conf
echo "es_AR.UTF-8 UTF-8" >> /etc/locale.gen

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

locale-gen

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime

pacman --noconfirm --needed -S broadcom-wl networkmanager xf86-video-intel xorg-server xorg-xinit xorg-xbacklight xorg-xsetroot xorg-setxkbmap

systemctl enable NetworkManager

pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm --needed -S pamixer pulseaudio pulsemixer vim git gvfs ntfs-3g gnu-free-fonts dmenu

pacman --noconfirm --needed -S htop neofetch sxiv ranger zip unzip xwallpaper picom ueberzug

curl -O https://raw.githubusercontent.com/SMhub1975/arch/master/30-touchpad.conf
curl -O https://raw.githubusercontent.com/SMhub1975/arch/master/00-keyboard.conf

cat <<-'EOF'

        _____   __  __   _               _       __    ___    ______   _____
       / ____| |  \/  | | |             | |     /_ |  / _ \  |____  | | ____|
      | (___   | \  / | | |__    _   _  | |__    | | | (_) |     / /  | |__
       \___ \  | |\/| | | '_ \  | | | | | '_ \   | |  \__, |    / /   |___ \
       ____) | | |  | | | | | | | |_| | | |_) |  | |    / /    / /     ___) |
      |_____/  |_|  |_| |_| |_|  \__,_| |_.__/   |_|   /_/    /_/     |____/

# arch-chroot /mnt
# Ingrese root passwd
# useradd -m -g wheel archi
# Ingrese archi passwd
# mkinitcpio -p linux
# grub-mkconfig -o /boot/grub/grub.cfg
# Edite xinit para arrancar dwm y smbar
# Marcar particion booteable
# git clone https://aur.archlinux.org/brave-bin.git
# git clone https://git.suckless.org/dwm
# git clone https://git.suckless.org/st
# git clone https://github.com/SMhub1975/arch.git

EOF

passwd
