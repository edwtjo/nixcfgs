{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    nixops
    nix-exec
    nix-repl
    nox
  ];
}
