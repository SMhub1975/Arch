## Edite previamente los tamaños de las particiones

loadkeys es

lsblk

iwctl

station wlan0 connect "Fibertel WiFi363 2.4GHz"

ping www.google.com

curl -O https://raw.githubusercontent.com/SMhub1975/arch/master/archi.sh

sh archi.sh

## Post instalacion

vim /etc/sudoers

vim /etc/mkinitcpio.conf

HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)

HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)

vim /etc/default/grub

GRUB_TIMEOUT=0

GRUB_CMDLINE_LINUX="cryptdevice=UUID=UUID-del-dispositivo:cryptroot" root=/dev/mapper/cryptroot

GRUB_CMDLINE_LINUX="cryptdevice=UUID=UUID-del-dispositivo:cryptlvm" root=/dev/cryptvol/root

grub-mkconfig -o /boot/grub/grub.cfg

mkinitcpio -p linux

Ingrese root passwd
arch-chroot /mnt
useradd -m -g wheel archi
Ingrese archi passwd

Edite xinit para arrancar dwm y smbar

Marcar particion booteable

git clone https://git.suckless.org/dwm

git clone https://github.com/SMhub1975/arch

exit

umount -R /mnt

## USB

https://mags.zone/help/arch-usb.html

dd if=/dev/zero of=/dev/sdX status=progress

sgdisk -o -n 1:0:+10M -t 1:EF02 -n 2:0:+500M -t 2:EF00 -n 3:0:0 -t 3:8300 /dev/sdX

pacman -S grub efibootmgr

grub-install --target=i386-pc --recheck /dev/sdX
grub-install --target=x86_64-efi --efi-directory /boot --recheck --removable

grub-mkconfig -o /boot/grub/grub.cfg

mover los "block" y "keyboard" hooks antes del "autodetect" hook

HOOKS=(base udev block keyboard autodetect keymap consolefont modconf encrypt filesystems fsck)

## Decrypt_1

cryptsetup open /dev/sda2 cryptroot

mount /dev/mapper/cryptroot /mnt

mount /dev/sda1 /mnt/boot

arch-chroot /mnt

## Decrypt_2

cryptsetup open --type luks /dev/sda2 cryptlvm

mount /dev/cryptvol/root /mnt

mount /dev/sda1 /mnt/boot

arch-chroot /mnt

## Mount options

To prevent excess writes to the USB and improve system performance, use the noatime mount option in fstab.

Open /etc/fstab in an editor and change each relatime or atime option to noatime:

vim /etc/fstab

/dev/sdY3

UUID=uuid1  /      ext4  rw,noatime     0 1

/dev/sdY2

UUID=uuid2  /boot  vfat  rw,noatime,... 0 2

## Journal config

To prevent the systemd journal service from writing to the USB, change the storage settings in journald.conf. Edit a drop-in file to contain the following content:

mkdir -p /etc/systemd/journald.conf.d

vim /etc/systemd/journald.conf.d/10-volatile.conf

[Journal]
Storage=volatile
SystemMaxUse=16M
RuntimeMaxUse=32M
