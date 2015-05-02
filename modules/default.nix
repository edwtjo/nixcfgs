{ config, lib, pkgs, ... }:

with lib;

{
  options = { tjonix = mkOption { options = []; }; };
  imports = [
    ./admin.nix
    ./infinality.nix
    ./synchome.nix
    ./mosh.nix
  ];
}
