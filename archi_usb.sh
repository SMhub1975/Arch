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

sgdisk -o -n 1:0:+10M -t 1:EF02 -n 2:0:+500M -t 2:EF00 -n 3:0:0 -t 3:8300 /dev/sdb

timedatectl set-ntp true

partprobe

cryptsetup -y -v luksFormat /dev/sdb3
cryptsetup open /dev/sdb3 cryptroot

mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

mkfs.fat -F32 /dev/sdb2
mkdir -p /mnt/boot
mount /dev/sdb2 /mnt/boot

pacstrap /mnt base base-devel linux

genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/SMhub1975/arch/master/archi2.sh > /mnt/archi2.sh && arch-chroot /mnt bash archi2.sh && rm /mnt/archi2.sh