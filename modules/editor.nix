{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    fzf
    ripgrep
    lazygit
    fd
  ];
}
