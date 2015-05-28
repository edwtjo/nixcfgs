{ config, pkgs, ... }:
{
  users.extraUsers.revvpn = {
      createHome = true;
      uid = 1900;
      group = "revvpn";
      openssh.authorizedKeys.keys = [
        "/etc/nixos/user/revvpn.pub"
      ];
      home = "/home/revvpn";
      shell = pkgs.zsh + "/bin/zsh";
  };
  users.extraGroups.revvpn.gid = 1900;

  systemd.services.revvpn = {
     description = "Reverse tunnel";
     wantedBy = [ "multi-user.target" ];
     after = [ "network.target" ];
     serviceConfig = {
       User = "revvpn";
       Group = "revvpn";
       Restart = "always";
       RestartSec = "1200";
       ExecStart = "${pkgs.openssh}/bin/ssh -NTC -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no revvpn@nexus.cube2.se -R 50022:localhost:22";
     };
   };

  systemd.services.revproxy = {
     description = "Reverse Proxy";
     wantedBy = [ "multi-user.target" ];
     after = [ "network.target" ];
     serviceConfig = {
       User = "revvpn";
       Group = "revvpn";
       Restart = "always";
       RestartSec = "1200";
       ExecStart = "${pkgs.openssh}/bin/ssh -NTC -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no revvpn@nexus.cube2.se -R 51080:localhost:1080";
     };
   };


}
