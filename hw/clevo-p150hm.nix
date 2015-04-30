{ config, pkgs, ... }:

{
  boot = {
    initrd = {
      supportedFilesystems = [ "jfs" "ext2" "btrfs" ];
      extraUtilsCommands =
      ''
        cp -v ${pkgs.jfsutils}/sbin/fsck.jfs $out/bin
      '';
      kernelModules = [ "ehci_hcd" "ahci" "xhci_hcd" "shpchp" "usb_storage" "jfs" ];
    };
    kernelModules = [ "kvm-intel" "fuse" "mmc_core" ];
    extraModulePackages = with pkgs; [ jfsutils btrfsProgs ];
    postBootCommands = ''
      # enable SD card reader
      echo 1 > /sys/bus/pci/rescan
    '';
  };

  environment.systemPackages = with pkgs; [
    btrfsProgs
    jfsutils
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

  hardware.opengl.driSupport32Bit = true;

  systemd.services."screen-mirror-on-dvi" = {
    description = "mirror screens to DVI on X11 startup.";
    after = [ "graphical.target" ];
    serviceConfig = {
      ExecStart =
      let
        mirror-screens = pkgs.writeScriptBin "mirror-screens" ''
          #!/bin/sh
          ${pkgs.xlibs.xrandr} --output LVDS-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DVI-I-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-I-0 --off --output HDMI-0 --off
        '';

      in
        "${mirror-screens}/bin/mirror-screens";
    };
  };
}
