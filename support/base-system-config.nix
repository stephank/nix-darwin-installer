{
  system.stateVersion = 4;
  documentation.enable = false;
  users.nix.configureBuildUsers = true;
  users.nix.nrBuildUsers = 4;
  services.nix-daemon.enable = true;
  services.activate-system.enable = false;
  programs.bash.enable = false;
}
