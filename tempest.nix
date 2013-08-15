{config, pkgs, ...}:

{
  require = [
    ./hw/clevo-p150hm.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/sda";

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

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
    hostName = "tempest";
  };

  services.openssh.enable = true;

}

