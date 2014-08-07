{ config, pkgs, ... }:

# AMD E350D APU platform

{
  boot.vesa = true;
  boot.kernelPackages = pkgs.linuxPackages_3_15;
  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" "usbhid" "btrfs" ];
  boot.kernelModules = [ "kvm-amd" "btrfs" ];
  boot.extraModulePackages = [ pkgs.btrfsProgs ];
  boot.kernelParams = [ "fbcon=map:1" "video=vesafb:off" "console=ttyS0,115200n8" ];
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [ firmwareLinuxNonfree ];
  nix.maxJobs = 2;
  boot.initrd.luks.devices = [
    { name = "cryptfs"; device = "/dev/sda3"; }
	  ];
  # EFI BOOT
  # This isn't required since the latest firmware made BIOS boot more reliable functional
  #boot.loader.grub.enable = false;
  #boot.loader.gummiboot.enable = true;
  #boot.loader.gummiboot.timeout = 2;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efibootmgr.partition = 2;
  #boot.loader.efi.efibootmgr.efiDisk = "/dev/sda";
  # BIOS BOOT
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    extraConfig = "serial; terminal_output.serial";
  };

  services.mingetty = {
    serialSpeed = [ 115200 ];
    helpLine = ''
      WELCOME TO PRISM TERMINAL INTERFACE
    '';
  };
}
