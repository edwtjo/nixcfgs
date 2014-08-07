{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.es
    aspellDicts.sv
    dictdWiktionary
    dictdWordnet
    ghostscript
    #texLiveFull
    haskellPackages.pandoc
  ];
}
