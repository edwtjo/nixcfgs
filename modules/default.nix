{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./admin.nix
    ./infinality.nix
    ./emacs.nix
    ./synchome.nix
    ./mosh.nix
    ./nginx.nix
  ];
}
