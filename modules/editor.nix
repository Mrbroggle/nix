{ pkgs, config, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    lazygit
    fd
  ];
}
