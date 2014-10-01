{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.2";
  src = fetchgit {
    url = "https://github.com/edwtjo/nixin";
    rev = "800614c28c0ff080e942743d597d27e771fc52e4";
    sha256 = "0gaf82wgkk5p2fpjvkzzp6j8cxbmyvil5yv5wdms224rawslzpwh";
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
