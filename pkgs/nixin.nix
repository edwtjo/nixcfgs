{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "nixin-${version}";
  version = "0.1";
  src = fetchgit {
    url = "https://github.com/edwtjo/nixin";
    rev = "aea505c8baccb86b079a32ef4962966d02b85149";
    sha256 = "0p9g9zbn6cdw6mdyhi5cxws7jkli457fidyknnvrjnmkdp03y4q8";
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
