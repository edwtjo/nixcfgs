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
    ./pkgs/nixin.nix
    ./user/edwtjo.nix
    ./user/admin.nix
  ];

  nixpkgs.config.allowUnfree = true; # Hallowed be thy name

  remote.admin.enable = true;
  remote.admin.users = [ "edwtjo" ];

  nix.package = pkgs.nixUnstable;

  boot = {
    kernelPackages = pkgs.linuxPackages_3_15;
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  nixpkgs.config.packageOverrides = pkgs:
  { linux_3_15 = pkgs.linux_3_15.override {
      extraConfig =
        ''
          PCI_DEBUG y
        '';
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
      fsType = "btrfs";
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
    openvpn.servers = {
      hypercube = {
        config = ''
          client
          proto udp
          dev tap
          remote nexus.cube2.se 2194
          comp-lzo
          verb 3
          cipher  AES-256-CBC
          cert 	/root/.vpn/hypercube/tempest.crt
          key 	/root/.vpn/hypercube/tempest.key
          ca 	/root/.vpn/hypercube/ca.crt
          dh	/root/.vpn/hypercube/dh4096.pem
          persist-key
          persist-tun
          status /root/.vpn/hypercube/openvpn-status.log
	      '';
	      autoStart = false;
      };
    };
  };
}
