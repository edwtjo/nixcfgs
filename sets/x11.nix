{ config, pkgs, ...}:

{
  environment.x11Packages = with pkgs; [
    firefox
    gimp
    gqview
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    inkscape
    libreoffice
    mplayer
    rdesktop
    #read-edid
    scrot
    vlc
    wine
    x2vnc
    xdg_utils
    xorg.xauth
    xournal
    xsel
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
