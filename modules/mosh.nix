{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.tjonix.mosh;
  moshOpts = {
    enable = mkOption {
      default = false;
    };
  };

in

{
  options.tjonix.mosh = moshOpts;

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ mosh ];
    networking.firewall.allowedUDPPortRanges = [{ from = 60000; to = 61000; }];
  };
}
