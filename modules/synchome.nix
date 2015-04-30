{ config, lib, pkgs, ...}:

with lib;

let

  cfg = config.tjonix.synchome;
  synchomeOptions = {
    synchome = {
      enable = mkOption {
        default = false;
      };
      user = mkOption {
        default = "nobody";
      };
      unison = mkOption {
        default = pkgs.unison;
      };
    };
  };
  synchome = unison: writeScriptBin "synchome" ''
    #!/bin/sh
    source ~/.keychain/$HOSTNAME-sh
    export PATH=${pkgs.openssh}/bin:$PATH # since unison calls ssh
    ${unison}/bin/unison $HOSTNAME -ui text -batch -prefer newer -times -logfile /tmp/unison-$USER-$(${pkgs.coreutils}/bin/date +%F-%T).log
  '';
in
{
  options.tjonix = mkOption { options = [ synchomeOptions ]; };

  config = mkIf cfg.enable {
    systemd.services."${user}-synchome" = {
      description = "Synchronizes users HOME";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
        serviceConfig = {
        User = user;
        Group = user;
        Type = "simple";
        Restart = "always";
        RestartSec = "1200";
        ExecStart = "${synchome unison}/bin/synchome";
      };
    };
  };
}
