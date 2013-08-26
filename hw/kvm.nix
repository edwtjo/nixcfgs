{ pkgs, config, ... }:

{
  boot.initrd.availableKernelModules = [ "virtio_net" "virtio_pci" "virtio_blk" ];
  boot.kernelModules = [ "tun" "virtio_baloon" "virtio_console" ];
}
