{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    androidsdk_4_1
    ant
    maven
    ideas.idea_community
    openjdk
  ];
}
