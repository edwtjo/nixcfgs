{ config, pkgs, modulesPath, ... }:

{
  boot.initrd.luks.devices = [
    { name = "cryptfs"; device = "/dev/sda3"; }
    { name = "cryptswap"; device = "/dev/sda2"; }
  ];
  boot.initrd.luks.cryptoModules = ["aes" "sha256" "sha1" "xts"];
  boot.initrd.postMountCommands = "cryptsetup luksOpen --key-file /mnt-root/root/.swapkey /dev/sda2 cryptswap";
}
