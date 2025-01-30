{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    (vivaldi.override {
	    proprietaryCodecs = true;
	    enableWidevine = false;
    })
  ];
}
