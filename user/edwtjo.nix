{config, pkgs, ...}:
{
  users.extraUsers.edwtjo = {
      createHome = true;
      uid = 1000;
      group = "edwtjo";
      openssh.authorizedKeys.keys = [
        "/etc/nixos/user/edwtjo.pub"
      ];
      extraGroups = [ "users" "wheel" ];
      description = "Edward Tjörnhammar";
      home = "/home/edwtjo";
      shell = pkgs.zsh + "/bin/zsh";
  };
  users.extraGroups.edwtjo.gid = 1000;
}
