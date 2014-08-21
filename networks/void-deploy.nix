{
  htpc =
    { config, pkgs, ... }:
    { deployment.targetEnv = "none";
      deployment.targetHost = "prism.q";
    };
  #gateway =
  #  { config, pkgs, ...}:
  #  { deployment.targetEnv = "none";
  #    deployment.targetHost = "nexus.q";
  #  };
}
