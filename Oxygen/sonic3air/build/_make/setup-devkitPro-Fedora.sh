#!/bin/bash
# https://devkitpro.org/wiki/devkitPro_pacman#Fedora
dnf install pacman
mkdir -p /opt/devkitpro
echo "
[dkp-libs]
Server = https://pkg.devkitpro.org/packages

[dkp-linux]
Server = https://pkg.devkitpro.org/packages/linux/$arch/
" | sudo tee -a /etc/pacman.conf
pacman-key --init
pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0
pacman -U https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.zst
pacman-key --populate devkitpro
pacman -Syu
pacman -S devkitpro-pacman
echo '
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITPRO/tools/bin/:$PATH

' >> ~/.bashrc
source ~/.bashrc
pacman -S switch-pkg-config devkitA64 switch-tools switch-sdl2 switch-glad switch-glm switch-libogg switch-libopus switch-libvorbis switch-libtheora
make PLATFORM=Switch -j $(nproc)
