{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    ihaskell
  ( with haskellPackages; [
#    Agda
#    AgdaStdlib
    cabalInstall
    cabal2nix
#    cabalDev
    ghc
    ghcCore
    ghcMod
    haddock
    haskellPlatform
    hasktags
    hlint
    hoogle
    stylishHaskell
    ihaskell
  ])
  ];
}
