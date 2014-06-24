{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
  ( with haskellPackages; [
    Agda
    AgdaStdlib
    cabalInstall
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
  ])
  ];
}
