{config, pkgs, ...}:

{

  environment = {
    systemPackages = with pkgs; [
      acpi
      wpa_supplicant
    ];

    x11Packages = with pkgs; [
      wpa_supplicant_gui
    ];
  };

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

  networking = {
    wireless = {
      enable = true;
      interface = "wlan0";
      userControlled.enable = true;
    };
  };

  powerManagement.enable = true;

}
