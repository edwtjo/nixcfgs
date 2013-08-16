{config, pkgs, ...}:

{
  require = [
    ./hw/dell-latitude-d420.nix
    ./hw/encrypted-root.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/sda";

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/mapper/cryptfs";
      fsType = "jfs";
    }
  ];

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];

  networking = {
      hostName = "forge";
  };

  services.openssh.enable = true;
}

