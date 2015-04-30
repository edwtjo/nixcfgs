{ config, pkgs, ... }:

{

  imports = [
    ./hw/clevo-p150hm.nix

    ./pkgs
    ./modules

    ./sets/common.nix
    ./sets/mail.nix
    ./sets/laptop.nix
    ./sets/writing.nix
    ./sets/virtualization.nix
    ./sets/music.nix
    ./sets/x11.nix
    ./sets/media.nix
    ./sets/games.nix
    ./sets/math.nix
    ./sets/developer.nix
    ./user/edwtjo.nix
    ./user/htpc.nix
  ];

  nixpkgs.config.allowUnfree = true; # Hallowed be thy name
  nixpkgs.config.allowBroken = true; # Gotta catch them all!

  tjonix.admin.enable = true;
  tjonix.admin.users = [ "edwtjo" ];
  tjonix.infinality.enable = true;
  tjonix.synchome = {
    enable = true;
    user = "edwtjo";
    unison = pkgs.unison_2483;
  };

  nix.package = pkgs.nixUnstable;

  boot = {
    kernelPackages = pkgs.linuxPackages_3_18;
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
    useDHCP = true;
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

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Adwaita
    gtk-icon-theme-name=gnome
    gtk-font-name=Liberation Sans 15
    gtk-cursor-theme-name=Adwaita
    gtk-cursor-theme-size=0
    gtk-toolbar-style=GTK_TOOLBAR_BOTH
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=1
    gtk-menu-images=1
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintslight
    gtk-xft-rgba=rgb
  '';
}
