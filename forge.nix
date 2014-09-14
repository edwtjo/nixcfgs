{config, pkgs, ...}:

{
  imports = [
    ./hw/dell-latitude-d420.nix
    ./hw/encrypted-root.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/writing.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/sda";

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/mapper/cryptfs";
      fsType = "jfs";
    }
    { mountPoint = "/boot";
     device = "/dev/sda1";
     fsType = "ext2";
    }
  ];

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];

  networking = {
      hostName = "forge";
  };

  services.xserver.xkbModel = "pc105";
  #nix.proxy = "http://www-gw.foi.se:8080";
}
