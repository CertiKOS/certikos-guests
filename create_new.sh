dd if=/dev/zero of=flash1.img bs=1M count=64
dd if=/dev/zero of=flash0.img bs=1M count=64
dd if=/usr/share/qemu-efi-aarch64/QEMU_EFI.fd of=flash0.img conv=notrunc
qemu-img create ubuntu-image.img 20G
wget http://ports.ubuntu.com/ubuntu-ports/dists/focal-updates/main/installer-arm64/current/legacy-images/netboot/mini.iso
qemu-system-aarch64 -nographic -machine virt,gic-version=max -m 512M -cpu max -smp 4 \
	-netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 \
	-device virtio-net-pci,netdev=vnet \
	-drive file=ubuntu-image.img,if=none,id=drive0,cache=writeback \
	-device virtio-blk,drive=drive0,bootindex=0 \
	-drive file=mini.iso,if=none,id=drive1,cache=writeback \
	-device virtio-blk,drive=drive1,bootindex=1 \
	-drive file=flash0.img,format=raw,if=pflash -drive file=flash1.img,format=raw,if=pflash
