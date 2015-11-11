{ config, lib, pkgs, ... }:

# 15" (12,4) Mac Book Pro with R9 M370X
# AFAICT it needs the proprietary fglrx driver, "ati_unfree" in NixOS
# kernel patches shamelessly stolen from
# https://bugzilla.kernel.org/show_bug.cgi?id=96771#c26
# Also stole snippets from @cstrahan @puffnfresh and @mbbx6pp

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];

  boot.kernelModules = [ "msr" "coretemp" "applesmc" "hid_apple" "kvm-intel" ];
  boot.blacklistedKernelModules = [ "radeon" ];
  boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelParams = [ "video=vesafb:off" "modprobe.blacklist=radeon" ];
  boot.kernelPackages = pkgs.linuxPackages_macpro;
  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  boot.cleanTmpDir = true;

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    enableAllFirmware = true;
  };

  services.actkbd.enable = true;
  services.actkbd.bindings = [
    { keys = [ 113 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }
    { keys = [ 114 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master 5-"; }
    { keys = [ 115 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master 5+"; }
    { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 4"; }
    { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 4"; }
    { keys = [ 229 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight up"; }
    { keys = [ 230 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight down"; }
  ];

  services.mbpfan.enable = true;
  services.xserver = {
    enable = true;
    autorun = true;
    videoDrivers = [ "intel" "ati_unfree" ];
    xkbOptions = "ctrl:nocaps,lv3:switch,compose:lwin";
    xkbVariant = "mac";

    deviceSection = ''
       Option "BusID" "PCI:1:0:1"
       Option "DPMS" "true"
       Option "ChipID" "0x6938"
    '';

    moduleSection = ''
      load "dri2"
      load "glx"
    '';

    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.buttonsMap = [ 1 3 2 ];
    synaptics.tapButtons = false;
    synaptics.accelFactor = "0.0055";
    synaptics.minSpeed = "0.95";
    synaptics.maxSpeed = "1.15";
    synaptics.palmDetect = true;
    synaptics.additionalOptions = ''
      Option "RTCornerButton" "2"
      Option "RBCornerButton" "3"
    '';
  };

  nix.maxJobs = 8;

  system.activationScripts.drifix = ''
    mkdir -p /usr/lib/dri
    ln -sf /run/opengl-driver/lib/dri/fglrx_dri.so /usr/lib/dri/fglrx_dri.so
  '';

  nixpkgs.config.packageOverrides = self: with self;
  let
      macpro-sources = linux_4_1.override { /* because fglrx compat */
        kernelPatches = [
          ({
            patch = ../kernel/mbp-fn-key.patch;
            name = "macpro-fn-key";
          })
          ({
            patch = ../kernel/mbp-trackpad-multitouch.patch;
            name = "macpro-trackpad-multitouch";
          })
        ];
      };
  in
  {
    linuxPackages_macpro = recurseIntoAttrs (linuxPackagesFor macpro-sources linuxPackages_4_1);
  };
}
