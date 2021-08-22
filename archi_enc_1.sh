#!/bin/bash

timedatectl set-ntp true

partprobe

cryptsetup -y -v luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptroot

mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

mkfs.ext4 /dev/sda1
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base linux

genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/SMhub1975/arch/master/archi2.sh > /mnt/archi2.sh && arch-chroot /mnt bash archi2.sh && rm /mnt/archi2.sh

###############################################################################################################################################

# cryptsetup open /dev/sda2 cryptroot
# mount /dev/mapper/cryptroot /mnt
# mount /dev/sda1 /mnt/boot
# vim /etc/mkinitcpio.conf___HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)
# vim /etc/default/grub___cryptdevice=UUID=UUID-del-dispositivo:cryptroot root=/dev/mapper/cryptroot
# mkinitcpio -p linux
# grub-mkconfig -o /boot/grub/grub.cfg
