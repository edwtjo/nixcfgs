{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [ 
    acpi 
    wpa_supplicant
  ];

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

  networking = {
    wireless.enable = true;
    wicd.enable = false;
  };

  powerManagement.enable = true;
}

