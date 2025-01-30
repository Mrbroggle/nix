{...}: {
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "8:00" ];
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
}
