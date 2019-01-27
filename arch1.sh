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

loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4 создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +100M;

  echo n;
  echo;
  echo;
  echo;
  echo +10G;
  
#Если нужен swap-расскомментировать  
  #echo n;
  #echo p;
  #echo;
  #echo;
  #echo +1024M;

  echo n;
#Если сделали swap-расскомментировать
#echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
#Если сделан swap:расскомментировать строку и изменить номер у директории "home"(изменить на sda4)
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
#mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sda3 -L home

echo '3.1 Выбор зеркал для загрузки. Ставим зеркало'
#echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
echo "Server = http://mirrors.prok.pw/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL https://raw.github.com/Pushkin31/arch2019/master/arch_2.sh)"