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

mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel linux

genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/SMhub1975/arch/master/archi2.sh > /mnt/archi2.sh && arch-chroot /mnt bash archi2.sh && rm /mnt/archi2.sh