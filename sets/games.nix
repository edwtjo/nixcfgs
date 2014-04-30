{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    bzflag
    freeciv
    gnuchess
    lincity_ng
    # minetest
    nethack
    openlierox
    openttd
    #scorched3d
    superTux
    superTuxKart
    steam
    steamChrootEnv
    wesnoth
    widelands
    #tremulous
    zangband
    xboard
    xonotic
  ];
}
