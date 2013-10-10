{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    libvirt
    ssvnc
    virtinst
    virtmanager
    qemu_kvm
  ];

  virtualisation.libvirtd.enable = true;

  users.extraGroups = [
  {
    name = "libvirtd";
  }
  ];
}
