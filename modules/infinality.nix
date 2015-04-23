{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.tjonix.infinality;
  tjopts = options.tjonix;

  infinalityOpts = {

    infinality = {
      enable =  mkOption {
        default = false;
        example = true;
        description = "Enable full infinality support";
      };
    };

  };

in

{
  options.tjonix = mkOption { options = [ infinalityOpts ]; };

  config = mkIf cfg.enable {
    #for fontname in `ls fontconfig/infinality/conf.d.infinality/*.conf`;do echo environment.etc.\"fonts/conf.d/$fontname\".source = ../$fontname\;;done
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/10-base-rendering.conf".source = ../fontconfig/infinality/conf.d.infinality/10-base-rendering.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/10-scale-bitmap-fonts.conf".source = ../fontconfig/infinality/conf.d.infinality/10-scale-bitmap-fonts.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/28-user.conf".source = ../fontconfig/infinality/conf.d.infinality/28-user.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/29-local.conf".source = ../fontconfig/infinality/conf.d.infinality/29-local.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/35-repl-custom.conf".source = ../fontconfig/infinality/conf.d.infinality/35-repl-custom.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/36-repl-missing-glyphs.conf".source = ../fontconfig/infinality/conf.d.infinality/36-repl-missing-glyphs.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/37-repl-webfonts.conf".source = ../fontconfig/infinality/conf.d.infinality/37-repl-webfonts.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/38-repl-proggy-bitmap.conf".source = ../fontconfig/infinality/conf.d.infinality/38-repl-proggy-bitmap.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/38-repl-terminus-bitmap.conf".source = ../fontconfig/infinality/conf.d.infinality/38-repl-terminus-bitmap.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/38-repl-webfonts-custom.conf".source = ../fontconfig/infinality/conf.d.infinality/38-repl-webfonts-custom.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/40-non-latin-microsoft.conf".source = ../fontconfig/infinality/conf.d.infinality/40-non-latin-microsoft.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/40-non-latin-misc.conf".source = ../fontconfig/infinality/conf.d.infinality/40-non-latin-misc.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/45-latin-microsoft.conf".source = ../fontconfig/infinality/conf.d.infinality/45-latin-microsoft.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/45-latin-misc.conf".source = ../fontconfig/infinality/conf.d.infinality/45-latin-misc.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/49-sansserif.conf".source = ../fontconfig/infinality/conf.d.infinality/49-sansserif.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/67-override-aliases.conf".source = ../fontconfig/infinality/conf.d.infinality/67-override-aliases.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/68-override.conf".source = ../fontconfig/infinality/conf.d.infinality/68-override.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/82-no-bitmaps.conf".source = ../fontconfig/infinality/conf.d.infinality/82-no-bitmaps.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/82-no-embedded-bitmaps.conf".source = ../fontconfig/infinality/conf.d.infinality/82-no-embedded-bitmaps.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/82-no-force-autohint.conf".source = ../fontconfig/infinality/conf.d.infinality/82-no-force-autohint.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/82-no-postscript.conf".source = ../fontconfig/infinality/conf.d.infinality/82-no-postscript.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/82-no-ttf-as-bitmap.conf".source = ../fontconfig/infinality/conf.d.infinality/82-no-ttf-as-bitmap.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/83-yes-bitmaps.conf".source = ../fontconfig/infinality/conf.d.infinality/83-yes-bitmaps.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/83-yes-embedded-bitmaps.conf".source = ../fontconfig/infinality/conf.d.infinality/83-yes-embedded-bitmaps.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/83-yes-force-autohint.conf".source = ../fontconfig/infinality/conf.d.infinality/83-yes-force-autohint.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/83-yes-postscript.conf".source = ../fontconfig/infinality/conf.d.infinality/83-yes-postscript.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/83-yes-ttf-as-bitmap.conf".source = ../fontconfig/infinality/conf.d.infinality/83-yes-ttf-as-bitmap.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/88-forced-synthetic.conf".source = ../fontconfig/infinality/conf.d.infinality/88-forced-synthetic.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/90-non-tt-fonts.conf".source = ../fontconfig/infinality/conf.d.infinality/90-non-tt-fonts.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/90-tt-fonts-microsoft.conf".source = ../fontconfig/infinality/conf.d.infinality/90-tt-fonts-microsoft.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/90-tt-fonts-misc.conf".source = ../fontconfig/infinality/conf.d.infinality/90-tt-fonts-misc.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/92-selective-rendering-microsoft.conf".source = ../fontconfig/infinality/conf.d.infinality/92-selective-rendering-microsoft.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/92-selective-rendering-misc.conf".source = ../fontconfig/infinality/conf.d.infinality/92-selective-rendering-misc.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/93-final-rendering.conf".source = ../fontconfig/infinality/conf.d.infinality/93-final-rendering.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/94-no-synthetic.conf".source = ../fontconfig/infinality/conf.d.infinality/94-no-synthetic.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/95-reject.conf".source = ../fontconfig/infinality/conf.d.infinality/95-reject.conf;
    environment.etc."fonts/conf.d/fontconfig/infinality/conf.d.infinality/97-selective-rendering-custom.conf".source = ../fontconfig/infinality/conf.d.infinality/97-selective-rendering-custom.conf;

     nixpkgs.config.packageOverrides = self: with self; {
       freetype = lib.overrideDerivation (freetype) (attrs: { useEncumberedCode = true; });
     };
   };
}