{ config, lib, pkgs, ...}:

with lib;

let

  cfg = config.tjonix.synchome;
  synchomeOptions = {
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
  synchome = unison: pkgs.writeScriptBin "synchome" ''
    #!/bin/sh
    source ~/.keychain/$HOSTNAME-sh
    export PATH=${pkgs.openssh}/bin:$PATH # since unison calls ssh
    ${unison}/bin/unison $HOSTNAME -ui text -batch -prefer newer -times -logfile /tmp/unison-$USER-$(${pkgs.coreutils}/bin/date +%F-%T).log
  '';
in
{
  options.tjonix.synchome = synchomeOptions;

  config = mkIf cfg.enable {
    systemd.services."${cfg.user}-synchome" = {
      description = "Synchronizes users HOME";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
        serviceConfig = {
        User = cfg.user;
        Group = cfg.user;
        Type = "simple";
        Restart = "always";
        RestartSec = "1200";
        ExecStart = "${synchome cfg.unison}/bin/synchome";
      };
    };
  };
}
