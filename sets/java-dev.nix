{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    androidsdk_4_1
    apacheAntOpenJDK
    maven
    ideas.idea_community_1301
  ];
}