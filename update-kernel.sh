if [ -z "$1" ]; then
  echo "You must specify a kernel version."
  exit 1
fi

VER=$1

if [ ! -f "${HOME}/linux-${VER}-x86.tar.zst" ]; then
  echo "linux-${VER}-x86.tar.zst does not exist."
  exit 2
fi

if [ -f oldver ]; then
  OLD_VER="$(cat oldver)"
  BOOT_PATH="/boot/*${OLD_VER}*"
  MOD_PATH="/lib/modules/*${OLD_VER}*"
  sudo rm -rf $BOOT_PATH $MOD_PATH
  echo "Removed old kernel version $OLD_VER"
fi

sudo tar -C / --zstd -xvf linux-${VER}-x86.tar.zst --keep-directory-symlink && rm linux-*

if [ -x /bin/mkinitcpio ]; then
  echo "Run mkinitcpio"
  sudo mkinitcpio -k ${VER} -g /boot/initramfs-${VER}.img
fi

if [ -x /bin/update-grub ]; then
  echo "Run update-grub"
  sudo update-grub
fi

sudo sync

echo $VER >oldver
echo "Installed kernel version $VER"
