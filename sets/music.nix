{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    aumix
    ardour3
    cmus
    guitarix
    hydrogen
    jack_rack
    mpg123
    ncmpcpp
    picard
    sox
    qjackctl
  ];
}

