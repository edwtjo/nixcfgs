{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    nixops
    nix-repl
  ];
}