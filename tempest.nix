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
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/mapper/crypthome";
      fsType = "ext4";
    };
  };

  swapDevices = [
    { device = "/dev/mapper/cryptswap"; }
  ];

  networking = {
    hostName = "tempest";
  };

  services = {
    openvpn.enable = true;
  };
}
