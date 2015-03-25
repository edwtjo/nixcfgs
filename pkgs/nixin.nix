{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.2.2";
  src = fetchgit {
    url = "https://github.com/edwtjo/nixin";
    rev = "f51afc8abf9510ea49effb02e2edaea8dfc70108";
    sha256 = "19fj6zx15n7lpx7scq3yrmjmx1z6c8cdhh99z791rx2z5iqvky72";
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
