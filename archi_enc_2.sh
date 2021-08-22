#!/bin/bash

timedatectl set-ntp true

partprobe

cryptsetup luksFormat /dev/sda2
cryptsetup open --type luks /dev/sda2 cryptlvm

pvcreate /dev/mapper/cryptlvm
vgcreate cryptvol /dev/mapper/cryptlvm

lvcreate -L 2G cryptvol -n swap
lvcreate -L 20G cryptvol -n root
lvcreate -l 100%FREE cryptvol -n home

mkfs.ext4 /dev/cryptvol/root
mkfs.ext4 /dev/cryptvol/home
mkswap /dev/cryptvol/swap

mount /dev/cryptvol/root /mnt
mkdir /mnt/home
mount /dev/cryptvol/home /mnt/home
swapon /dev/cryptvol/swap

mkfs.ext4 /dev/sda1
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel linux lvm2

genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/SMhub1975/arch/master/archi2.sh > /mnt/archi2.sh && arch-chroot /mnt bash archi2.sh && rm /mnt/archi2.sh

###############################################################################################################################################

# cryptsetup open --type luks /dev/sda2 cryptlvm
# mount /dev/cryptvol/root /mnt
# mount /dev/sda1 /mnt/boot
# vim /etc/mkinitcpio.conf___HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)
# vim /etc/default/grub___cryptdevice=UUID=UUID-del-dispositivo:cryptlvm root=/dev/cryptvol/root
# mkinitcpio -p linux
# grub-mkconfig -o /boot/grub/grub.cfg


