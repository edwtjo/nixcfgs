{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    libvirt
    #ssvnc
    virtinst
    virtmanager
    qemu
  ];
}
