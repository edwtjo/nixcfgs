with import <nixpkgs> {};

let

  xbmcFceux = ''
#!${pkgs.stdenv.shell}
game=`printf "%q" "$@"`
echo "`date +%Y%m%d-%H:%M:%S` <$game>"
export SDL_DSP_PATH=/dev/snd/controlC1
export SDL_AUDIODRIVER=alsa
${pkgs.fceux}/bin/fceux \
  --autoscale 1 \
  --keepratio 1 \
  --pal 0 \
  --fullscreen 1 \
  --newppu 1 \
  --opengl 1 \
  --sound 1 \
  --soundq 2 \
  --noframe 1 \
  --nogui \
  "$@"
'';
  xbmcFceuxSh = pkgs.writeScript "xbmc-fceux" xbmcFceux;

  xbmcZsnes = ''
#!${pkgs.stdenv.shell}
export SDL_DSP_PATH=/dev/snd/controlC1
export SDL_AUDIODRIVER=alsa
${pkgs.zsnes}/bin/zsnes \
        -y \
        -j \
        -ad alsa \
        -1 1 \
        -2 1 \
        -s \
        -v 4 \
        -m \
        "$@"
'';
  xbmcZsnesSh = pkgs.writeScript "xbmc-zsnes" xbmcZsnes;

in 

stdenv.mkDerivation rec {
  name = "xbmc-launchers-${version}";
  version = "0.1";
  dontBuild = true;
  unpackPhase = "mkdir -p $out/bin";
  installPhase = ''
    ln -s ${xbmcZsnesSh} $out/bin/xbmc-zsnes
    ln -s ${xbmcFceuxSh} $out/bin/xbmc-fceux
  '';
  meta = {
    description = "XBMC game launchers";
    license = "GPL-3";
  };
}
