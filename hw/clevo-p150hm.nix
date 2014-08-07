{ config, pkgs, ... }:

{
  boot = {
    initrd = {
      supportedFilesystems = [ "jfs" "ext2" ];
      extraUtilsCommands =
      ''
        # jfs on rootfs means we must have fsck
        cp -v ${pkgs.jfsutils}/sbin/fsck.jfs $out/bin
      '';
      kernelModules = [ "ehci_hcd" "ahci" "xhci_hcd" "shpchp" "usb_storage" "jfs" ];
    };
    kernelModules = [ "kvm-intel" "fuse" "mmc_core" ];
    extraModulePackages = [ pkgs.btrfsProgs ];
    postBootCommands = ''
      # enable SD card reader
      echo 1 > /sys/bus/pci/rescan
    '';
  };

  environment.systemPackages = with pkgs; [
    jfsutils
    jfsrec
    firmwareLinuxNonfree
  ];

  hardware.enableAllFirmware = true;

  nix = {
    extraOptions = ''
      build-cores = 8
    '';
    maxJobs = 8;
  };

  hardware.opengl.videoDrivers = [ "nvidia" ];
}
