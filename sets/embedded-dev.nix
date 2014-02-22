{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    arduino_core
    avrdude
    avrgcclibc
    minicom
    picocom
  ];
}
