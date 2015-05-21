{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.tjonix.admin;

  remoteAdminOptions = {
    enable = mkOption {
      default = false;
      example = true;
      description = "Enable support for remote admin.";
    };

    users = mkOption {
      default = [];
      type = types.listOf types.string;
      example = {
        remoteRootKeys = [ "me" "myself" "andi" ];
      };
      description = ''
        These users has remote root ssh, implies ssh service and that they
        have known SSH public keys.
        !!NOTE THE INSANE SECURITY RISK THIS IMPOSES!!
        '';
    };
  };
in

{
  options.tjonix.admin = remoteAdminOptions;

  config = mkIf cfg.enable {

    services.openssh = {
      enable = true;
      # we don't need no stinking passwords
      passwordAuthentication = false;
    };

    users.extraUsers.root.openssh.authorizedKeys.keyFiles =
      concatMap (usr: usr.openssh.authorizedKeys.keyFiles) (filter (usr: elem usr.name cfg.users) (attrValues config.users.extraUsers));
  };
}
