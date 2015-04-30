# Trying out sytem wide repo local package definitions :)
with (import <nixpkgs> { inherit (builtins.currentSystem); }).pkgs;
rec {
  nixpkgs.config.packageOverrides = self : with self; {

    xfce = xfce // {
      libxfce4ui = lib.overrideDerivation (xfce.libxfce4ui) (attrs:  {
        postInstall = '' # don't you dare mess with my meta key
          sed -i -e "/Super/d" $out/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
        '';
      });
    };

    nixin = import ./nixin.nix {
      inherit (pkgs) stdenv fetchFromGitHub;
    };

    unison_22757 = import ./unison-2.27.57.nix {
      inherit (pkgs) stdenv fetchurl lablgtk fontschumachermisc xset makeWrapper ncurses;
      ocaml = ocaml_3_08_0;
    };

    unison_23252 = import ./unison-2.32.52.nix {
      inherit (pkgs) stdenv fetchurl lablgtk fontschumachermisc xset makeWrapper ncurses;
      ocaml = ocaml_3_11_2;
      enableX11 = false;
    };

    unison_24063 = import ./unison-2.40.63.nix {
      inherit (pkgs) stdenv fetchurl lablgtk fontschumachermisc xset makeWrapper ncurses;
      ocaml = ocaml_4_00_1;
      enableX11 = false;
    };

    unison_2483 = import ./unison-2.48.3.nix {
      inherit (pkgs) stdenv fetchurl lablgtk fontschumachermisc xset makeWrapper ncurses;
      ocaml = ocaml_4_02_1;
      enableX11 = false;
    };

  };
}
