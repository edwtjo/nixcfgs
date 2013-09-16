{ config, pkgs, modulesPath, ... }:

{
  boot.initrd.luks.devices = [
    { name = "cryptfs"; device = "/dev/sdb3"; }
  ];
  boot.initrd.luks.cryptoModules = ["aes" "sha256" "sha1" "xts"];
  boot.initrd.postMountCommands = "cryptsetup luksOpen --key-file /mnt-root/root/.swapkey /dev/sdb2 cryptswap";
}
