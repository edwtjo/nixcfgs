{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
  ( with haskellPackages; [
    cabalInstall
    cabalDev
    ghc
    ghcCore
    haddock
    haskellPlatform
    hasktags
    hlint
    hoogle
    stylishHaskell
  ])
  ];
}
