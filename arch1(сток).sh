#!/bin/bash

# Установочный скрипт ALFI (от Arch Linux Full Install - Полная установка Arch Linux)
# Цель скрипта - быстрое развертывание системы с вашими персональными настройками (KDE(или XFCE), темы, программы и т.д.).

# В разработке принимали участие:
# Алексей Бойко https://vk.com/ordanax
# Степан Скрябин https://vk.com/zurg3
# Михаил Сарвилин https://vk.com/michael170707
# Данил Антошкин https://vk.com/danil.antoshkin

# Корректировали:
# Александр Хрипушин https://vk.com/aleks_hripushin
# Артём Духовный https://vk.com/hoasker

echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

loadkeys ru
setfont cyr-sun16

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

  echo n;
  echo;
  echo;
  echo;
  echo +200M;

  echo n;
  echo;
  echo;
  echo;
  echo +25G;

  echo n;
  echo;
  echo;
  echo;
  echo +25G;
  echo a;
  echo 1;

  #echo n;
  #echo;
  #echo;
  #echo;
  #echo;
  #echo a;
  #echo 1;

  echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda3 -L boot
mkfs.ext4  /dev/sda4 -L root
mkfs.ext4  /dev/sda5 -L home

echo '2.4.3 Монтирование дисков'
mount /dev/sda4 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda3 /mnt/boot
mount /dev/sda5 /mnt/home

echo '3.1 Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL https://raw.github.com/Pushkin31/arch2019/master/arch_2.sh)"
