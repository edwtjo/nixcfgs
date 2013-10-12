{ config, pkgs, ... }:

{
  require = [
    <nixos/modules/installer/scan/not-detected.nix>
  ];

  boot = {
    initrd = {
      supportedFilesystems = [ "jfs" "ext2" ];
      extraUtilsCommands =
      ''
        # jfs on rootfs means we must have fsck
        cp -v ${pkgs.jfsutils}/sbin/fsck.jfs $out/bin
      '';
      kernelModules = [ "ehci_hcd" "ahci" "xhci_hcd" "usb_storage" "jfs" ];
    };
    kernelModules = [ "kvm-intel" "fuse" ];
    extraModulePackages = [ "jfsutils" ];
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

  services.xserver.videoDrivers = [ "nvidia" ];
}
