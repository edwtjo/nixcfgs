# Trying out sytem wide repo local package definitions :)
let
  pkgs = import <nixpkgs> { inherit (builtins.currentSystem); };
  stdenv = pkgs.stdenv;
  lib = stdenv.lib;
in

rec {
  nixpkgs.config.packageOverrides = {

    nixin = import ./nixin.nix {
      inherit (pkgs) stdenv fetchgit;
    };

    xbmc-launchers = import ./xbmc-launchers.nix {
      inherit (pkgs) stdenv pkgs;
      cores = with pkgs.libretro;
      [
        _4do
        bsnes-mercury
        desmume
        fba
        fceumm
        gambatte
        genesis-plus-gx
        mupen64plus
        picodrive
        prboom
        ppsspp
        scummvm
        snes9x-next
        stella
        vba-next
      ];
    };

  };
}