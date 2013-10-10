{ config, pkgs, modulesPath, ... }:

{
  boot.initrd = {
    luks = {
      devices = [
        { name = "cryptfs"; device = "/dev/sda3"; }
      ];
      cryptoModules = ["aes" "sha256" "sha1" "xts"];
    };
    postMountCommands = ''
      cryptsetup luksOpen --key-file /mnt-root/root/.swapkey /dev/sda2 cryptswap;
      cryptsetup luksOpen --key-file /mnt-root/root/.homekey /dev/sdb1 crypthome;
    '';
  };
}
