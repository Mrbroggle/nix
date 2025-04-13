{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = false;
    })
    inputs.zen-browser.packages."${system}".default

  ];
}
