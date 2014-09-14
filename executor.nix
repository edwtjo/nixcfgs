{config, pkgs, ...}:

{
  imports = [
    ./hw/kvm.nix
    ./sets/common.nix
    ./sets/writing.nix
    ./sets/x11.nix
    ./sets/developer.nix
    ./sets/tomcat.nix
  ];

  environment.nix = pkgs.nixUnstable;

  boot = {
    kernelPackages = pkgs.linuxPackages_3_12;
    loader.grub = {
      device = "/dev/vda";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/vda1";
      fsType = "ext2";
    };

    "/" = {
      device = "/dev/vda3";
      fsType = "jfs";
    };
  };

  swapDevices = [
    { device = "/dev/vda2"; }
  ];

  networking = {
    hostName = "executor";
    useDHCP = true;
    defaultGateway = "192.168.0.1";
    nameservers = [ "150.227.50.1" ];
    interfaces = {
      name = "eth0";
      ipAddress = "192.168.0.102";
      subnetMask = "255.255.255.0";
    };
  };

  services = {
    cups = {
      enable = true;
    };
    openvpn.enable = true;
    services.samba.enable = true;
    tomcat.enable = true;
  };
}
