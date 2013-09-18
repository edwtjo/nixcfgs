{config, pkgs, ...}:

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
    ethtool
    fcron
    fetchmail
    flex
    fuse
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    gnupg
    gpm
    haskellPackages.ghc
    haskellPackages.haskellPlatform
    haskellPackages.hledger
    haskellPackages.hlint
    haskellPackages.hoogle
    #hfsplus
    htop
    iasl
    inetutils
    iptables
    irssi
    jfsutils
    keychain
    libtool
    libxml2
    libxslt
    links2
    lshw
    ltrace
    m4
    mairix
    manpages
    mc
    mercurial
    monotone
    mutt
    #nfs-utils
    nmap
    offlineimap
    openjdk
    openssh
    openvpn
    patchelf
    perlPackages.DBI perlPackages.DBDSQLite boehmgc perl sqlite
    pkgconfig
    pv
    python
    screen
    sqlite
    strace
    taskwarrior
    tcpdump
    tsocks
    unison
    vim
    wget
    which
    zlib
    zsh
  ];

  environment.shellInit = ''
  '';

  nix.useChroot = true;
  time.timeZone = "Europe/Stockholm";

  boot.initrd.kernelModules = [
    "jfs"
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
  };

  networking.interfaceMonitor.enable = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "sv-latin1";
    defaultLocale = "en_CA.UTF-8";
  };

  users.extraUsers = [
	{
		name = "edwtjo";
		uid = 1000;
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
		gid = 1000;
	}
  ];

  services.nixosManual.showManual = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.fcron.enable = true;
}

