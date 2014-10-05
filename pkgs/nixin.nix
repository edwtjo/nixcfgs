{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.2.1";
  src = fetchgit {
    url = "https://github.com/edwtjo/nixin";
    rev = "694f00402fc2a814b89e92d7bd1c7e0a05ab4075";
    sha256 = "01zwbavn3gzjcqxgmgz0kkxs87c03dw4sx1ab021cyp0yhg4nz9i";
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
