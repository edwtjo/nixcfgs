{config, pkgs, ...}:

{
  environment = {
    systemPackages = with pkgs; [
      acpi
      wpa_supplicant
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
      interfaces = [ "wlp4s0" ];
      userControlled.enable = true;
    };
  };

  powerManagement.enable = true;
}
