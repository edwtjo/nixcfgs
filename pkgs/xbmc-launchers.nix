{ stdenv, pkgs, cores }:

assert cores != [];

with pkgs.lib;

let

  init = list: take (length list - 1) list;

  script = exec: ''
    #!${stdenv.shell}
    nohup sh -c "sleep 1 && pkill -SIGSTOP xbmc" &
    nohup sh -c "${exec} '$@' -f;pkill -SIGCONT xbmc"
  '';
  scriptSh = exec: pkgs.writeScript ("xbmc-"+exec.name) (script exec.path);
  execs = zipListsWith
            (n: p: { name = n; path = p+"/bin/retroarch-"+n; })
            (map (drv: concatStringsSep "-" ((init(tail(splitString "-" drv.name))))) cores)
            (cores);

in

stdenv.mkDerivation rec {
  name = "xbmc-launchers-${version}";
  version = "0.2";

  dontBuild = true;

  buildCommand = ''
    mkdir -p $out/bin
    ${stdenv.lib.concatMapStrings (exec: "ln -s ${scriptSh exec} $out/bin/xbmc-${exec.name};") execs}
  '';

  meta = {
    description = "XBMC retroarch launchers";
    longDescription = ''
      These retroarch launchers are intended to be used with
      angelfires advanced launcher for XBMC since device input is
      caught by both XBMC and the retroarch process.
    '';
    license = "GPL-3";
  };
}
