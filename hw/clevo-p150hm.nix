{ config, pkgs, ... }:

{
  require = [
    <nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.kernelModules = [ "ehci_hcd" "ahci" "xhci_hcd" "firewire_ohci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" "fuse" ];
  boot.extraModulePackages = [ ];

  environment.systemPackages = with pkgs; [
    firmwareLinuxNonfree
  ];

  hardware.enableAllFirmware = true;

  nix.extraOptions = ''
    build-cores = 8
  '';
  nix.maxJobs = 8;

  services.xserver.videoDrivers = [ "nvidia" ];
}
