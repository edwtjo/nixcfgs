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
    graphviz
    texLiveFull
    haskellPackages.pandoc
  ];
}
