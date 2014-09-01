{ config, pkgs, ... }:

{
  require = [
    ./hw/acer-travelmate-5510.nix
    ./user/admin.nix
    ./user/edwtjo.nix
    ./user/fernando.nix
  ];

  remote.admin.enable = true;
  remote.admin.users = [ "edwtjo" ];

  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.memtest86.enable = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "sv-latin1";
    defaultLocale = "en_CA.UTF-8";
  };

  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "ext2";
    };

  swapDevices =[
    { device = "/dev/sda2"; }
  ];

  nix.maxJobs = 2;
  nix.gc.automatic = true;
  nix.gc.dates = "03:45";

  environment.variables.NIXPKGS_REPO = "/root/nixpkgs";

  environment.systemPackages = with pkgs; [
    acpi
    aumix
    audacious
    clementine
    firefoxWrapper
    libreoffice
    inkscape
    gimp
    glxinfo
    links2
    gqview
    nixin
    rdesktop
    wine
    xbmc
    keepassx
    wget
    lshw
    vim
    mupdf
    xsel
    screen
    xlockmore
    vlc
    gftp
    wpa_supplicant
    wpa_supplicant_gui
    p7zip
    sshfsFuse
    gnupg
    curl
    openvpn
    sudo
  ];

  services = {
    xserver = {
      enable = true;
      autorun = true;
      exportConfiguration = true;
      videoDrivers = [ "ati" "vesa" ];
      useGlamor = true;
      displayManager = {
        slim.enable = true;
      };
      desktopManager = {
        xfce.enable = true;
        default = "xfce";
      };
      layout = "se";
      xkbModel = "pc105";
      synaptics = {
        enable = true;
        twoFingerScroll = true;
      };
    };
    gpm.enable = true;
    printing.enable = true;
    openssh.enable = true;
    dbus.packages = with pkgs; [ gnome.GConf ];
    locate.enable = true;
    acpid.enable = true;

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
          cert 	/root/.vpn/hypercube/bismarck.crt
          key 	/root/.vpn/hypercube/bismarck.key
          ca 	/root/.vpn/hypercube/ca.crt
          dh	/root/.vpn/hypercube/dh4096.pem
          persist-key
          persist-tun
          status /root/.vpn/hypercube/openvpn-status.log
	'';
        autoStart = true;
      };
    };
  };

  powerManagement.enable = true;

  time.timeZone = "Europe/Stockholm";

  services.nixosManual.showManual = true;
  networking = {
    hostName = "bismarck";
    firewall.enable = false;
    useDHCP = true;
    enableB43Firmware = true;
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
      userControlled.enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableAdobeFlash = true;
      enableDjvu = true;
      enableFriBIDPlugin = true;
    };
    packageOverrides = pkgs: {
      nixin = pkgs.stdenv.mkDerivation rec {
        name = "nixin-0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/edwtjo/nixin";
          rev = "d14683f37046beddb4ae898c4da1cbcada1b1d47";
          sha256 = "bfd3bcfd06f37acea74d10ad5d38b327940c4b3b7f0f15f66e7501c0d2f26602";
        };
        installPhase = ''
          mkdir -p $out/bin
          install -D $src/nixin $out/bin/nixin
          patchShebangs $out
        '';
        meta = {
          description = "NixOS highlevel helper";
          homepage = "https://github.com/edwtjo/nixin/";
          license = "GPL-3";
        };
      };
    };
  };
  fonts.fonts = with pkgs; [
    dejavu_fonts
    corefonts
    vistafonts
    inconsolata
    anonymousPro
  ];
}
