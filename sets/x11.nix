{ config, pkgs, ...}:

{
  environment.x11Packages = with pkgs; [
    firefoxWrapper
    wine
    libreoffice
    MPlayer
    gqview
    scrot
    xorg.xauth
    rdesktop
    xournal
    inkscape
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    startOpenSSHAgent = true;
  };

  services.printing.enable = true;
}

