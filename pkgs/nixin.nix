with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.1";
  src = fetchgit {
    url = "https://github.com/edwtjo/nixin";
    rev = "d14683f37046beddb4ae898c4da1cbcada1b1d47";
    sha256 = "bfd3bcfd06f37acea74d10ad5d38b327940c4b3b7f0f15f66e7501c0d2f26602";
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

