# Trying out sytem wide repo local package definitions :)
let
  pkgs = import <nixpkgs> { inherit (builtins.currentSystem); };
in

rec {
  nixpkgs.config.packageOverrides = {

    nixin = import ./nixin.nix {
      inherit (pkgs) stdenv fetchgit;
    };

    xbmc-launchers = import ./xbmc-launchers.nix {
      inherit (pkgs) stdenv pkgs fceux zsnes;
    };

  };
}