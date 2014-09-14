{ config, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/base.nix"
    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  boot.initrd.kernelModules = [ "uhci_hcd" "ehci_hcd" "ata_piix" "firewire_ohci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  nix.maxJobs = 2;
}
