{ config, pkgs, ... }:
{
  nix = {
    useChroot = true;
    gc.automatic = true;
    daemonIONiceLevel = 7;
    daemonNiceLevel = 19;
    binaryCaches = [ "http://hydra.cryp.to" "http://cache.nixos.org" ];
    extraOptions = ''
      auto-optimise-store = true
      binary-caches-parallel-connections = 1
    '';
  };

  nixpkgs.config.unison.enableX11 = false;
  programs.zsh.enable = true;

  environment = {
    systemPackages = with pkgs;
      [
        abook
        bazaar
        bc
        cacert
        curl
        devicemapper
        dict
        docbook5
        docbook5_xsl
        emacs24
        encfs
        ethtool
        fdupes
        fcron
        fetchmail
        file
        flex
        fortune
        fuse
        fuse_exfat
        gnumake
        gnupg
        gpm
        htop
        iasl
        idutils
        inetutils
        iptables
        irssi
        keychain
        lftp
        libnotify
        libtool
        libxml2
        libxslt
        links2
        lm_sensors
        lshw
        lsof
        ltrace
        lxc
        m4
        manpages
        mc
        mercurial
        monotone
        mosh
        nixin
        nmap
        openjdk
        openssh
        openssl
        openvpn
        p7zip
        patchelf
        perl
        polkit
        posix_man_pages
        pkgconfig
        psmisc
        pv
        python
        sshfsFuse
        screen
        sqlite
        strace
        taskwarrior
        tcpdump
        tmux
        tsocks
        unison_24063
        #uptimed
        vim
        wget
        which
        zlib
        zsh
        slasktratten
        (with haskellngPackages; [ ShellCheck ])
      ];
      shellInit = ''
      '';
      variables =
      {
      NIX_PATH = pkgs.lib.mkOverride 0 [
        "nixpkgs=/etc/nixos/nixpkgs"
        "nixos=/etc/nixos/nixpkgs/nixos"
        "nixos-config=/etc/nixos/configuration.nix"
      ];
    };
  };

  time.timeZone = "Europe/Stockholm";

  boot = {
    cleanTmpDir = true;
    loader.grub = {
      enable = true;
      version = 2;
      memtest86.enable = true;
    };
  };

  networking.useDHCP = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "sv-latin1";
    defaultLocale = "en_CA.UTF-8";
  };

  security.sudo.enable = true;

  services = {
    nixosManual.showManual = true;
    openssh = {
      enable = true;
      passwordAuthentication = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [ hplip gutenprint cups_pdf_filter ];
    };
    fcron.enable = true;
    locate.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    sane.enable = false;
  };

  programs.ssh.startAgent = true;
}
