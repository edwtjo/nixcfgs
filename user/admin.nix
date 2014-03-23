{config, pkgs, ...}:

with pkgs.lib;

let
  cfg = config.remote.admin;

  remoteAdminOptions = {

    admin = {
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
  };
in

{
  options = {
    remote = mkOption {
      options = [ remoteAdminOptions ];
    };
  };

  config = mkIf cfg.enable {

    services.openssh = {
      enable = true;
      # we don't need no stinking passwords
      passwordAuthentication = false;
    };

    users.extraUsers.root.openssh.authorizedKeys.keyFiles = let
      isIn = needle: haystack: filter (p: p == needle) haystack != [];
      usersWithAdminKeys = attrValues (flip filterAttrs config.users.extraUsers (name: user:
        (length user.openssh.authorizedKeys.keys != 0) && (isIn user.name config.remote.admin.users)
      ));
      in
      concatMap (usr: usr.openssh.authorizedKeys.keys) usersWithAdminKeys;
  };
}
