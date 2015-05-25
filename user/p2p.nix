{ config, pkgs, ... }:
{
  users.extraUsers.p2p = {
      createHome = true;
      uid = 201001;
      group = "p2p";
      openssh.authorizedKeys.keyFiles = [
        ./keys/edwtjo-0.pub
      ];
      home = "/home/p2p";
      shell = pkgs.zsh + "/bin/zsh";
  };
  users.extraGroups.p2p.gid = 201001;
  users.extraUsers.transmission.extraGroups = [ "p2p" ];
}