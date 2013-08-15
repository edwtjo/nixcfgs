{ config, pkgs, modulesPath, ... }:

{
  require = [
    "${modulesPath}/profiles/base.nix"
    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  boot.initrd.kernelModules = [ "ohci_hcd" "ehci_hcd" "ahci" "ohci1394" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "acpi-cpufreq" "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  nix.maxJobs = 2;

  services.xserver.videoDrivers = [ "nvidia" ];
}

