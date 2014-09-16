{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    androidsdk_4_4
    ant
    maven
    idea.idea-community
    openjdk
  ];
}
