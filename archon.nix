{config, pkgs, ...}:

{
  require = [
    ./hw/kvm.nix
    ./sets/common.nix
    ./sets/laptop.nix
    ./sets/writing.nix
    ./sets/x11.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_3_10;

  boot.loader.grub.device = "/dev/vda";

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/vda3";
      fsType = "jfs";
    }
    { mountPoint = "/boot";
     device = "/dev/vda1";
     fsType = "ext2";
    }
  ];

  swapDevices = [
    { device = "/dev/vda2"; }
  ];

  networking = {
      hostName = "archon";
  };

  services.xserver.xkbModel = "pc105";

  environment.etc = {
    "resolvconf.conf".text =
      ''
        name_servers='192.168.2.60'
      '';
  };
}
