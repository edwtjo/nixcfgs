{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bzflag
    freeciv
    gnuchess
    lincity_ng
    minetest
    nethack
    openlierox
    openttd
    scorched3d
    superTux
    superTuxKart
    steam
    wesnoth
    widelands
    tremulous
    zangband
    xboard
    xonotic
  ];

  hardware = {
    pulseaudio.enable = false;
  };

}
