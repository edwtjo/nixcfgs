{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.2.4";
  src = fetchFromGitHub {
    owner = "edwtjo";
    repo = "nixin";
    rev = "93b5cad63af32db156559dbcaf2970b6bb50d13d";
    sha256 = "1gvycwbg5a999kn3n61ki173v5qxgzzi51gy2n6ppq9mcpbdipd9";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp $src/nixin $out/bin/nixin
    patchShebangs $out
  '';
  meta = {
    description = "NixOS highlevel helper";
    homepage = "https://github.com/edwtjo/nixin/";
    license = "GPL-3";
  };
}
