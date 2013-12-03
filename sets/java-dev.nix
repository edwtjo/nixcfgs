{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    apacheAntOpenJDK
    eclipses.eclipse_sdk_431
    maven
  ];
}