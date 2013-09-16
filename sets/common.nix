{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    abook
    #ack
    autoconf
    autogen
    automake
    bazaar
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
    #fribid
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
    #mausezahn
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
    #slocate
    #slrn
    #sshFuse
    sqlite
    strace
    taskwarrior
    tcpdump
    #tptest
    tsocks
    unison
    vim
    wget
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

