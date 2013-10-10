{ config, pkgs, ...}:
let maybeEmacs = if config.services.xserver.enable
                 then pkgs.emacs24
                 else null;
{
  environment.x11Packages = with pkgs; [
    bitcoin
    cinepaint
    conky
    darktable
    dcraw
    maybeEmacs
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
    rxvt_unicode
    scrot
    stalonetray
    vlc
    vimHugeX
    wine
    x2vnc
    xbmc
    xdg_utils
    xdotool
    xfontsel
    xlockmore # confirmed working noseguy
    xorg.xauth
    xournal
    xscreensaver
    xsel
  ];

  services = {
    avahi.enable = true;

    dbus = {
      packages = with pkgs; [ gnome.GConf ];
    };

    xserver = {
      enable = true;
      autorun = true;
      layout = "se";
      xkbModel = "pc105";

      windowManager = {
        xmonad.enable = true;
        default = "xmonad";
      };

      desktopManager = {
        xterm.enable = false;
        default = "none";
      };

      displayManager.kdm.enable = true;

      startOpenSSHAgent = true;
    };
  };

  nixpkgs.config = {
    firefox = {
      enableAdobeFlash = true;
      enableDjvu = true;
      enableFriBIDPlugin = true;
    };

    rxvt_unicode = {
      perlBindings = true;
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    extraFonts = with pkgs; [
       andagii
       anonymousPro
       arkpandora_ttf
       bakoma_ttf
       cantarell_fonts
       corefonts
       clearlyU
       cm_unicode
       dejavu_fonts
       freefont_ttf
       gentium
       inconsolata
       liberation_ttf
       libertine
       lmodern
       mph_2b_damase
       oldstandard
       theano
       tempora_lgc
       terminus_font
       ttf_bitstream_vera
       ucsFonts
       unifont
       vistafonts
       wqy_zenhei
    ];
  };
}
