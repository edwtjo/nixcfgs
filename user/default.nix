{ pkgs }:
rec {
  mkUser = name: id: desc: shell: groups: {
    users.extraUsers."${name}" = {
      createHome = true;
      uid = id;
      group = name;
      openssh.authorizedKeys.keyFiles = [
        (./. + "/keys/${name}-0.pub")
      ];
      extraGroups = [ "users" ] ++ groups;
      description = desc;
      home = "/home/${name}";
      shell = if shell == "zsh" then
        pkgs.zsh + "/bin/zsh"
	else
	pkgs.bash + "/bin/bash";
    };
    users.extraGroups."${name}".gid=id;
  };

  edwtjo = mkUser "edwtjo" 1000 "Edward Tjörnhammar" "zsh" [ "wheel" "audio" "video" "dailout" "cdrom" ];
  nela = mkUser "nela" 1002 "Marianela Garcia Lozano" "zsh" [ "wheel" ];

}
