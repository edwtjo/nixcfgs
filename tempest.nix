{config, pkgs, ...}:

{
  require = [
    ./hw/clevo-p150hm.nix
    ./hw/encrypted-root.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/writing.nix
    ./sets/virtualization.nix
    ./sets/music.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/sdb";

  fileSystems = [
    {
      mountPoint = "/";
      device = "/dev/mapper/cryptfs";
      fsType = "ext4";
    }
    {
      mountPoint = "/boot";
      device = "/dev/sdb1";
      fsType = "ext2";
    }
  ];

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];

  networking = {
    hostName = "tempest";
  };

  services.openssh.enable = true;
  services.xserver.xkbModel = "pc105";
}
