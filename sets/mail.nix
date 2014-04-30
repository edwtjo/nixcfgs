{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    abook
    fdm
    gnupg
    mairix
    mutt
    offlineimap
  ];
}
