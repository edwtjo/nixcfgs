{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    qjackctl
    jack_rack
    jackaudio
    guitarix
    hydrogen
    ardour3
  ];
}

