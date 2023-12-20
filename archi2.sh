#!/bin/bash

echo "arch" >> /etc/hostname
echo "LANG=es_AR.UTF-8" >> /etc/locale.conf
echo "es_AR.UTF-8 UTF-8" >> /etc/locale.gen

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

locale-gen

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime

pacman --noconfirm --needed -S networkmanager xf86-video-intel xorg-server xorg-xinit xorg-xbacklight xorg-xsetroot xorg-setxkbmap

#pacman --noconfirm --needed -S xf86-video-amdgpu intel-ucode amd-ucode dosfstools os-prober

systemctl enable NetworkManager

pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda
#pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda --removable --recheck

#pacman --noconfirm --needed -S grub efibootmgr && grub-install --target=x86_64-efi --efi-directory=/boot 
#pacman --noconfirm --needed -S grub efibootmgr && grub-install --target=x86_64-efi --efi-directory=/boot --removable --recheck

#grub-mkconfig -o /boot/grub/grub.cfg
#mkinitcpio -p linux

pacman --noconfirm --needed -S pamixer pulseaudio pulsemixer vim git gvfs ntfs-3g acsccid gnu-free-fonts dmenu xfce4-terminal ranger

pacman --noconfirm --needed -S htop neofetch zip unzip unrar xwallpaper picom ueberzug ttf-hanazono ttf-sazanami xorg-xclipboard xsel

pacman --noconfirm --needed -S thunar chromium mousepad ristretto vlc engrampa lxappearance libreoffice-fresh-es arc-gtk-theme papirus-icon-theme evince tumbler

curl -O https://raw.githubusercontent.com/SMhub1975/arch/master/30-touchpad.conf
curl -O https://raw.githubusercontent.com/SMhub1975/arch/master/00-keyboard.conf

cat <<-'EOF'

        _____   __  __   _               _       __    ___    ______   _____
       / ____| |  \/  | | |             | |     /_ |  / _ \  |____  | | ____|
      | (___   | \  / | | |__    _   _  | |__    | | | (_) |     / /  | |__
       \___ \  | |\/| | | '_ \  | | | | | '_ \   | |  \__, |    / /   |___ \
       ____) | | |  | | | | | | | |_| | | |_) |  | |    / /    / /     ___) |
      |_____/  |_|  |_| |_| |_|  \__,_| |_.__/   |_|   /_/    /_/     |____/

# Ingrese root passwd
# arch-chroot /mnt
# useradd -m -g wheel archi
# Ingrese archi passwd

EOF

passwd
