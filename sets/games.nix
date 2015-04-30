{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bzflag
    freeciv
    gnuchess
    minetest
    nethack
    openttd
    superTuxKart
    steam
    wesnoth
    zangband
  ];

  hardware = {
    pulseaudio.enable = false;
  };

}
