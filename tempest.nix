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
    ./sets/games.nix
    ./sets/developer.nix
  ];

  environment.nix = pkgs.nixUnstable;

  boot = {
    kernelPackages = pkgs.linuxPackages_3_11;
    loader.grub = {
      device = "/dev/sda";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/sda1";
      fsType = "ext2";
    };

    "/" = {
      device = "/dev/mapper/cryptfs";
      fsType = "jfs";
    };

    "/home" = {
      device = "/dev/mapper/crypthome";
      fsType = "jfs";
    };
  };

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];

  networking = {
    hostName = "tempest";
    interfaceMonitor.enable = true;
  };

  services = {
    openvpn.enable = true;
  };
}
