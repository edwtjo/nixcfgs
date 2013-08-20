{config, pkgs, ...}:

{
  environment.x11Packages = with pkgs; [
    wicd
  ];

  environment.systemPackages = [ pkgs.acpi ];

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

  networking = {
    wireless.enable = true;
    wicd.enable = true;
  };

  powerManagement.enable = true;
}

