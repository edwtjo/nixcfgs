{ config, pkgs, ...}:

{
  environment.x11Packages = with pkgs; [
    cinepaint
    conky
    darktable
    firefox
    gimp
    gqview
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    inkscape
    imagemagickBig
    libreoffice
    mplayer
    rdesktop
    #read-edid
    rxvt_unicode
    scrot
    vlc
    wine
    x2vnc
    xdg_utils
    xorg.xauth
    xournal
    xscreensaver
    xsel
  ];

  services.xserver = {
    enable = true;
    layout = "se";
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    startOpenSSHAgent = true;
  };

  services.printing.enable = true;
}
