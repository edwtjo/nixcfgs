{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    libvirt
    ssvnc
    virtinst
    virtmanager
    qemu
  ];

  virtualisation.libvirtd.enable = true;

  users.extraGroups = [
  {
    name = "libvirtd";
  }
  ];
}
