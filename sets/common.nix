{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    vim
    manpages
    gitAndTools.gitFull
    darcs
    monotone
    mercurial
    gnumake
    gcc
    libtool
    sqlite
    screen
    wget
    haskellPackages.ghc
    haskellPackages.haskellPlatform
    haskellPackages.shelly
    iptables
    nmap
    tcpdump
    irssi
    links
    mutt
    abook
    patchelf
    zlib
    automake
    autogen
    autoconf
    m4
    libtool
    pkgconfig
    perlPackages.DBI perlPackages.DBDSQLite boehmgc perl sqlite
    bison
    flex
    docbook5
    docbook5_xsl
    libxml2
    libxslt
    gdb
    ltrace
    darcs
    bazaar
    clang
    cmake
    python
    devicemapper
    xdg_utils
    mc
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
}

