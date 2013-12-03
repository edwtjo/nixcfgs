{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    cscope
    valgrind
  ];
}