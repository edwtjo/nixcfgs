{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    androidsdk_4_4
    ant
    gitRepo
    maven
    idea.idea-community
    openjdk
  ];
}
