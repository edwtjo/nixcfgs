{ config, pkgs, ...}:

{
  environment.x11Packages = with pkgs; [
    cinepaint
    conky
    darktable
    dcraw
    firefoxWrapper
    gimp
    gqview
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    inkscape
    imagemagickBig
    keepassx
    libreoffice
    mplayer
    mupdf
    rdesktop
    #read-edid
    rxvt_unicode
    scrot
    vlc
    vimHugeX
    wine
    x2vnc
    xbmc
    xdg_utils
    xdotool
    xfontsel
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

  nixpkgs.config = {
    firefox = {
      enableAdobeFlash = true;
      enableDjvu = true;
      enableFriBIDPlugin = true;
      #enableMPlayer = true;
    };

    rxvt_unicode = {
      perlBindings = true;
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    extraFonts = [
       pkgs.andagii
       pkgs.anonymousPro
       pkgs.arkpandora_ttf
       pkgs.bakoma_ttf
       pkgs.cantarell_fonts
       pkgs.corefonts
       pkgs.clearlyU
       pkgs.cm_unicode
       pkgs.dejavu_fonts
       pkgs.freefont_ttf
       pkgs.gentium
       pkgs.inconsolata
       pkgs.liberation_ttf
       pkgs.libertine
       pkgs.lmodern
       pkgs.mph_2b_damase
       pkgs.oldstandard
       pkgs.theano
       pkgs.tempora_lgc
       pkgs.terminus_font
       pkgs.ttf_bitstream_vera
       pkgs.ucsFonts
       pkgs.unifont
       pkgs.vistafonts
       pkgs.wqy_zenhei
    ];
  };
}
