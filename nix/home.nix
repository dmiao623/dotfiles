{ config, lib, pkgs, ... }:

{
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./dotfiles/kitty.nix
    ./dotfiles/skhd.nix
    ./dotfiles/qutebrowser.nix
  ];

  home.file = {
    ".config/neofetch/config.conf".source = ./dotfiles/misc/neofetch.conf;
    ".config/yabai/yabairc".source        = ./dotfiles/misc/yabai.conf;
    ".config/yadm/bootstrap".source       = ./dotfiles/misc/yadm-bootstrap.sh;
    ".config/yadm/encrypt".source         = ./dotfiles/misc/yadm-encrypt.conf;
    ".qutebrowser/blocked-hosts".source   = ./dotfiles/private/qutebrowser-blocked-hosts;
    ".qutebrowser/quickmarks".source      = ./dotfiles/private/qutebrowser-quickmarks;
    ".simplebarrc".source                 = ./dotfiles/misc/simplebar.json;
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    VISUAL = "nvim";
    EDITOR = "nvim";
    PS1 = "$ ";
  };
}
