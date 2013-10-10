{ config, pkgs, ... }:

{
  require = [
    <nixos/modules/installer/scan/not-detected.nix>
  ];

  boot = {
    initrd.kernelModules = [ "ehci_hcd" "ahci" "xhci_hcd" "usb_storage" ];
    kernelModules = [ "kvm-intel" "fuse" ];
    extraModulePackages = [ ];
  }

  environment.systemPackages = with pkgs; [
    firmwareLinuxNonfree
  ];

  hardware.enableAllFirmware = true;

  nix = {
    extraOptions = ''
      build-cores = 8
    '';
    maxJobs = 8;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
