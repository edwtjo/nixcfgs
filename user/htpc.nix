{config, pkgs, ...}:
{
  users.extraUsers.htpc = {
      createHome = true;
      uid = 1001;
      group = "htpc";
      openssh.authorizedKeys.keys = [
        "/etc/nixos/user/edwtjo.pub"
      ];
      extraGroups = [ "users" "wheel" ];
      description = "HTPC";
      home = "/home/htpc";
      shell = pkgs.zsh + "/bin/zsh";
  };
  users.extraGroups.htpc.gid = 1001;
}
