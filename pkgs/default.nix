# Trying out sytem wide repo local package definitions :)
with (import <nixpkgs> { inherit (builtins.currentSystem); }).pkgs;
rec {
  nixpkgs.config.packageOverrides = self : with self; {

    tjoNix = lib.overrideDerivation (nix) (attrs: {
      name = "nix-1.9pre4100_4bbcfaf";

      src = fetchurl {
        url = "http://hydra.nixos.org/build/21565942/download/4/${name}.tar.xz";
        sha256 = "1jcy0n8mi17k5vk89vammfh74lvsgnm4gjsk23cq1shspjnbbgxs";
      };
      patches = [];
    });

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

    jfsrec = import ./jfsrec.nix {
      inherit (pkgs) stdenv fetchurl boost;
    };

    slasktratten = import ./slasktratten.nix {
      inherit (pkgs) stdenv fetchurl writeText writeScriptBin coreutils jdk openssh;
      unison = pkgs.unison_2483;
    };
  };
}
