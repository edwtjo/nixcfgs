{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    gnuplot
    maxima
    octave
  ];
}
