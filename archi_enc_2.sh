#!/bin/bash

#        _____   __  __   _               _       __    ___    ______   _____
#       / ____| |  \/  | | |             | |     /_ |  / _ \  |____  | | ____|
#      | (___   | \  / | | |__    _   _  | |__    | | | (_) |     / /  | |__
#       \___ \  | |\/| | | '_ \  | | | | | '_ \   | |  \__, |    / /   |___ \
#       ____) | | |  | | | | | | | |_| | | |_) |  | |    / /    / /     ___) |
#      |_____/  |_|  |_| |_| |_|  \__,_| |_.__/   |_|   /_/    /_/     |____/
#
#
# Edite previamente los tamaños de las particiones

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
mkdir -p /mnt/home
mount /dev/cryptvol/home /mnt/home
swapon /dev/cryptvol/swap

mkfs.ext4 /dev/sda1
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel linux lvm2

genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/SMhub1975/arch/master/archi2.sh > /mnt/archi2.sh && arch-chroot /mnt bash archi2.sh && rm /mnt/archi2.sh