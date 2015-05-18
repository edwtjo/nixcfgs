{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    abook
    fdm
    gnupg
    mairix
    mutt
    urlview
    offlineimap
  ];

  systemd.services.edwtjo-mailsync = {
     description = "Synchronizes and indexes my maildirs";
     wantedBy = [ "multi-user.target" ];
     serviceConfig = {
       User = "edwtjo";
       Restart = "always";
       RestartSec = "300";
       ExecStart = if config.networking.hostName == "executor" then
       ''
         ${pkgs.offlineimap}/bin/offlineimap -q -a edward@foi.se
       ''
       else
       ''
         ${pkgs.offlineimap}/bin/offlineimap -q
       '';
     };
   };
}
