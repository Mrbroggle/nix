{...}: {
  nix = {
    optimise.automatic = true;
    optimise.dates = ["07:45"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
