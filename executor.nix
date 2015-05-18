{ config, pkgs, ... }:

{
  imports = [
    ./hw/optiflex-f755.nix

    ./pkgs
    ./modules

    ./secrets/foi.nix

    ./sets/common.nix
    ./sets/writing.nix
    ./sets/mail.nix
    ./sets/x11.nix
    ./sets/developer.nix
    ./user/edwtjo.nix
    ./user/revvpn.nix
  ];

  nix.package = pkgs.nixUnstable;
  nixpkgs.config.allowUnfree = true;

  tjonix.admin.enable = true;
  tjonix.admin.users = [ "edwtjo" ];
  tjonix.infinality.enable = true;
  tjonix.synchome = {
    enable = true;
    user = "edwtjo";
    unison = pkgs.unison_2483;
  };

  boot = {
    loader.grub = {
      device = "/dev/sda";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "UUID=abdb4c2c-bfbb-4231-81fc-487793231ba6";
      fsType = "ext2";
    };

    "/" = {
      device = "/dev/mapper/cryptfs";
      fsType = "jfs";
      encrypted = {
        enable = true;
        blkDev = "UUID=6fc36404-b6f5-42d4-803c-97d3cb304cfc";
        label = "cryptfs";
      };
    };
  };

  swapDevices = [
    { device = "UUID=2daec470-001f-409a-8d2a-36545ecf1d16"; }
  ];

  networking = {
    hostName = "executor";
    useDHCP = true;
  };

  services = {
    samba.enable = true;
    tomcat.enable = false;
  };
}
