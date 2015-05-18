{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    (with altcoins; [ bitcoin dogecoin ])
    cinepaint
    conky
    darktable
    dcraw
    dunst
    emacs24
    firefoxWrapper
    gimp
    ( with gnome; [
    GConf
    gnomeicontheme
    gvfs
    ])
    gqview
    gtk
    gvfs
    hicolor_icon_theme
    inkscape
    imagemagickBig
    keepassx
    libreoffice
    (with sweethome3d; [ application textures-editor furniture-editor ])
    mupdf
    polkit_gnome
    rdesktop
    rxvt_unicode
    rxvt_unicode.terminfo
    scrot
    shared_mime_info
    stalonetray
    vimHugeX
    wine
    transmission_gtk
    transmission_remote_gtk
    x2vnc
    ( with xfce; [
    exo
    gvfs
    gtk_xfce_engine
    thunar
    thunar_volman
    thunar_archive_plugin
    xfdesktop
    xfce4icontheme
    xfce4settings
    xfconf
    ])
    xdg_utils
    xdotool
    xfontsel
    xlockmore # confirmed working noseguy
    xorg.xmessage
    xorg.xauth
    xournal
    xsel
    (haskell-ng.packages.ghc7101.override {
       overrides = self: super: {
         xmobar = super.xmobar.override {
           mkDerivation = (attrs: self.mkDerivation (attrs // {
             configureFlags = [
              "-fwith_threaded" "-fwith_xpm" "-fwith_dbus"
              "-fwith_mpris" "-fwith_datezone" "-fwith_alsa"
              "-f-with_mpd" "-fwith_iwlib" "-fwith_inotify" "-fwith_utf8"
              "-fwith_xft"
             ];
           }));
         };
       };}).xmobar
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
        xmonad = {
          enable = true;
          haskellPackages = pkgs.haskell-ng.packages.ghc7101;
          enableContribAndExtras = true;
        };
        default = "xmonad";
      };

      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
        default = "xfce";
      };

      displayManager.slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/jagajaga/nixos-slim-theme/archive/1.0.tar.gz";
          sha256 = "08ygjn5vhn3iavh36pdcb15ij3z34qnxp20xh3s1hy2hrp63s6kn";
        };
      };

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

    conky = {
      mpdSupport = true;
      x11Support = true;
      curlSupport = true;
      xdamageSupport = true;
      imlib2Support = true;
      alsaSupport = true;
      wirelessSupport = true;
      luaSupport = true;
      rssSupport = true;
      weatherMetarSupport = true;
      weatherXoapSupport = true;
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
       andagii
       anonymousPro
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
       terminus_font
       ttf_bitstream_vera
       ucsFonts
       vistafonts
       wqy_zenhei
    ];
  };
}
