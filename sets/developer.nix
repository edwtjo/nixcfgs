{config, pkgs, ...}:
{
  require = [
    ./java-dev.nix
    ./haskell-dev.nix
    ./nix-dev.nix
  ];
  environment.systemPackages = with pkgs; [
    autoconf
    autogen
    automake
    bison
    boehmgc
    clang
    cmake
    darcs
    gcc
    gdb
    gitAndTools.gitFull
  ];
}