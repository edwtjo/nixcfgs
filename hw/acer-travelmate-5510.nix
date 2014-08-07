{ config, pkgs, ... }:

{ 
  boot.vesa = true;
  boot.kernelPackages = pkgs.linuxPackages_3_15;
  boot.initrd.availableKernelModules = [ "sata_sil" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" ];
  boot.kernelModules = [ "kvm-amd" "wl" "fbcon" ];
  boot.kernelParams = [ "fbcon=map:1" "radeon.dpm=0" "video=vesafb:off" ];

  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [ firmwareLinuxNonfree ];
}
