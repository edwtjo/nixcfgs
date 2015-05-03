{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./admin.nix
    ./infinality.nix
    ./synchome.nix
    ./mosh.nix
  ];
}
