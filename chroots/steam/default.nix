let pkgs = import <nixpkgs> {};
in
rec {
  steam = import ./steam.nix {
    inherit (pkgs) stdenv fetchurl dpkg;
  };

  steamChrootEnv = import ./steamChrootEnv.nix {
    inherit (pkgs.gnome) zenity;
    inherit (pkgs.xorg) libX11;
    inherit (pkgs) buildFHSChrootEnv steam xterm python mesa xdg_utils dbus_tools alsaLib coreutils which;
  };
}