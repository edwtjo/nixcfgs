{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.tjonix.usermacs;

  emacs = pkgs.emacsWithPackages
    (with pkgs.emacsPackages; with pkgs.emacsPackagesNg; [
      auctex
      company
      #company-ghc
      diminish
      evil
      #evil-indent-textobject
      evil-leader
      #evil-surround
      flycheck
      #ghc-mod
      git-auto-commit-mode
      git-timemachine
      haskell-mode
      helm
      magit
      markdown-mode
      monokai-theme
      org-plus-contrib
      #org
      rainbow-delimiters
      undo-tree
      use-package
    ]);

  startEmacsServer = pkgs.writeScript "start-emacs-server" ''
    #!/bin/sh
    source ${config.system.build.setEnvironment}
    source ~/.keychain/$HOSTNAME-sh
    ${emacs}/bin/emacs --daemon
  '';

in

{
  options.tjonix.usermacs = {
    enable = mkEnableOption "Emacs User Service";
    hsPkgs = mkOption {
      default = pkgs.haskellPackages;
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.emacs = {
      description = "Emacs Daemon";
      enable = true;
      path = (with pkgs; [ emacs silver-searcher ])
          ++ [ (cfg.hsPkgs.ghcWithPackages ( pkgs: with pkgs; [ ghc-mod stylish-haskell hlint structured-haskell-mode ])) ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "${startEmacsServer}";
        ExecStop = "${emacs}/bin/emacsclient --eval (kill-emacs)";
        Restart = "always";
      };
      wantedBy = [ "default.target" ];
    };
  };
 }
