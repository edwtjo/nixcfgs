{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.tjonix.synchome;

  unisonUserService = unison: ({
    "synchome-${replaceChars ["."] [""] unison.version}" = {
    description = "Runs synchome in batch mode";
    enable = true;
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${synchome unison}/bin/synchome-${unison.version}";
      ExecStop = "${pkgs.procps}/bin/pkill unison";
      RestartSec = "1200";
      Restart = "always";
      };
    };
  });

  synchome = unison: pkgs.writeScriptBin ("synchome-"+unison.version) ''
    #!/bin/sh
    . ${config.system.build.setEnvironment}
    source ~/.keychain/$HOSTNAME-sh
    export PATH=${pkgs.openssh}/bin:$PATH # since unison calls ssh
    ${pkgs.coreutils}/bin/nohup ${unison}/bin/unison $HOSTNAME -ui text -batch -prefer newer -times -logfile /tmp/unison-$USER-$(${pkgs.coreutils}/bin/date +%F-%T).log &
  '';

in

{
  options.tjonix.synchome = {
    enable = mkEnableOption "Synchome User Service";
    userService = mkOption {
      default = true;
      type = types.bool;
      description = "Add user service";
    };

    type = with types; loaOf optionSet;
    unisons = mkOption {
      default = [];
      type = with types; listOf package;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = cfg.unisons;
    systemd.user.services = mkIf cfg.userService (lib.fold (x: y: lib.recursiveUpdate x y) {} (map unisonUserService cfg.unisons));
  };
 }
