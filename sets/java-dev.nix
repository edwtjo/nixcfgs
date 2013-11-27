{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    eclipses.eclipse_sdk_431
  ];
}