{config, pkgs, ...}:

with pkgs.lib;

{

  ###### interface

  options = {
    q.admin.remoteRootKeys = mkOption {
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

  ###### implementation

  config = {

    services.openssh = {
      enable = true;
      # we don't need no stinking passwords
      passwordAuthentication = false;
    };

    users.extraUsers.root.openssh.authorizedKeys.keyFiles =
      concatMap (name: config.users.extraUsers.${name}.openssh.authorizedKeys.keys)
        config.q.admin.remoteRootKeys;
  };

}
