{config, pkgs, ...}:
let maybeEmacs = if ! config.services.xserver.enable
                 then pkgs.emacs24
                 else null;
in
{
  environment.systemPackages = with pkgs; [
    abook
    autoconf
    autogen
    automake
    bazaar
    bc
    bison
    clang
    cmake
    curl
    darcs
    devicemapper
    dict
    docbook5
    docbook5_xsl
    encfs
    maybeEmacs
    ethtool
    fcron
    fetchmail
    file
    flex
    fuse
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    gnupg
    gpm
    haskellPackages.cabalDev
    haskellPackages.ghc
    haskellPackages.haskellPlatform
    haskellPackages.hledger
    haskellPackages.hlint
    haskellPackages.hoogle
    htop
    iasl
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
    perlPackages.DBI perlPackages.DBDSQLite boehmgc perl sqlite
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
    w3m
    wget
    which
    zlib
    zsh
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

  users.extraUsers = [
	{
    createHome = true;
		name = "edwtjo";
		group = "edwtjo";
		extraGroups = [ "users" "wheel" ];
		description = "Edward Tjörnhammar";
		home = "/home/edwtjo";
		shell = pkgs.zsh + "/bin/zsh";
	}
  ];

  users.extraGroups = [
	{
		name = "edwtjo";
	}
  ];

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
