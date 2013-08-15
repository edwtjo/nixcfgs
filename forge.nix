{config, pkgs, ...}:

{
  require = [
    ./hw/dell-latitude-d420.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/sda";

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/sda3";
      fsType = "jfs";
    }
  ];

  swapDevices = [
    { device = "/dev/sda2"; }
  ];

  networking = {
      hostName = "forge";
  };

  services.openssh.enable = true;
}

