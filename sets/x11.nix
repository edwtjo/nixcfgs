{ config, pkgs, ...}:

let maybeEmacs = if config.services.xserver.enable
                 then pkgs.emacs24
                 else null;
in
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
    gnome.gnomeicontheme
    gqview
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    gtk
    hicolor_icon_theme
    inkscape
    imagemagickBig
    keepassx
    libreoffice
    mplayer
    mupdf
    rdesktop
    rxvt_unicode
    scrot
    shared_mime_info
    stalonetray
    vlc
    vimHugeX
    wine
    x2vnc
    xbmc
  ] ++ ( with xfce; [
    xfdesktop
    gvfs
    gtk_xfce_engine
    thunar
    thunar_volman
    thunar_archive_plugin
    xfce4icontheme
    xfce4settings
    xfconf
  ] ) ++ [
    xdg_utils
    xdotool
    xfontsel
    xlockmore # confirmed working noseguy
    xorg.xauth
    xournal
    xsel
    zathura
  ];

  environment.shellInit = ''
      # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
      export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0

      # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
      export GTK_DATA_PREFIX=${config.system.path}

      # Set GIO_EXTRA_MODULES so that gvfs works.
      export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules
  '';

  environment.pathsToLink = [ "/share/xfce4" "/share/themes" "/share/mime" "/share/desktop-directories"];

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
        xfce.enable = true;
        default = "xfce";
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
