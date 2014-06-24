{config, pkgs, ...}:

{
  require = [
    ./hw/clevo-p150hm.nix
    ./sets/common.nix
    ./sets/mail.nix
    ./sets/laptop.nix
    ./sets/writing.nix
    ./sets/virtualization.nix
    ./sets/music.nix
    ./sets/x11.nix
    ./sets/math.nix
    ./sets/developer.nix
    ./user/edwtjo.nix
    ./user/admin.nix
  ];

  nixpkgs.config.allowUnfree = true; # Hallowed be thy name

  remote.admin.enable = true;
  remote.admin.users = [ "edwtjo" ];

  nix.package = pkgs.nixUnstable;

  boot = {
    kernelPackages = pkgs.linuxPackages_3_14;
    loader.grub = {
      enable = true;
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
      encrypted = {
        enable = true;
        blkDev = "/dev/sda3";
        label = "cryptfs";
      };
      fsType = "jfs";
    };

    "/home" = {
      device = "/dev/mapper/crypthome";
      encrypted = {
        enable = true;
        blkDev = "/dev/sdb1";
        label = "crypthome";
        keyFile = "/root/.homekey";
      };
      fsType = "jfs";
    };
  };

  swapDevices = [
    { device = "/dev/mapper/cryptswap";
      encrypted = {
        enable = true;
        blkDev = "/dev/sda2";
        label = "cryptswap";
        keyFile = "/root/.swapkey";
      };
    }
  ];

  networking = {
    hostName = "tempest";
    interfaceMonitor.enable = true;
    firewall.enable = false;
  };

  services = {
    openvpn.enable = true;
  };
}
