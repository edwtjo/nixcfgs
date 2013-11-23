{stdenv, fetchurl, dpkg}:

stdenv.mkDerivation {
  name = "steam-1.0.0.42";
  src = fetchurl {
    url = http://repo.steampowered.com/steam/archive/precise/steam-launcher_1.0.0.42_all.deb;
    sha256 = "1jyvk0h1z78sdpvl4hs1kdvr6z2kwamf09vjgjx1f6j04kgqrfbw";
  };
  buildInputs = [ dpkg ];
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/usr/* $out
    rm -Rf $out/usr
  '';
}
