{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnuplot
    maxima
    octave
    ( with pythonPackages; [ numpy scipy matplotlib ipython cvxopt ])
  ];
}
