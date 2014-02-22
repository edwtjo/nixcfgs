{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    abook
    bazaar
    bc
    curl
    devicemapper
    dict
    docbook5
    docbook5_xsl
    emacs24
    encfs
    ethtool
    fcron
    fetchmail
    file
    flex
    fortune
    fuse
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
    mairix
    manpages
    mc
    mercurial
    monotone
    mosh
    mutt
    nmap
    offlineimap
    openjdk
    openssh
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
    unison
    vim
    wget
    which
    zlib
    zsh
    ( with perlPackages; [
    DBI
    DBDSQLite
    ])
    ( with haskellPackages; [
    DAV
    dbus
    hledger
    zlib
    ])
  ];

  environment.shellInit = ''
  '';

  nix = {
    useChroot = true;
    gc.automatic = true;
  };

  time.timeZone = "Europe/Stockholm";

  boot.loader.grub = {
    enable = true;
    version = 2;
    memtest86 = true;
  };

  networking.interfaceMonitor.enable = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "sv-latin1";
    defaultLocale = "en_CA.UTF-8";
  };

  users = {
    extraUsers.edwtjo =
	  {
      createHome = true;
      uid = 1000;
		  group = "edwtjo";
		  extraGroups = [ "users" "wheel" ];
		  description = "Edward Tjörnhammar";
		  home = "/home/edwtjo";
		  shell = pkgs.zsh + "/bin/zsh";
		   openssh.authorizedKeys.keys = [
		   "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2UX8S8A0kER3VqZZc53uHdOBMDpgIziuEu27Ws2PGWrvFCsHiTxxh/Hu5h+c+NHgS3hIqEKwmTHJXZKIozFjhmhRzf6yPnOItQqva9895qmKpHXCnAFWEfAP0IbZCo/wSEyzm+zLdUi3vDxe/ko2jbDjzyg6ZgJYPDVcqCYP6z4gem9/GvgcblEgoa1xnIxrTn42CWSoZRsjOXshpmCsJnfGu61zrqejAQLkP6rP05ngklJN5ZMPltXr1UzrfO2pr3ie5UJBqBbbS/0rQoK+Z2SBRHp0JuvzGaM3ppw2O9IA9dZAHMVeJiMysSoTx3Y48oAxhs6HLBYBZP5wqu/61Q== "
		   ];
	  };
    extraGroups.edwtjo.gid = 1000;
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
}
