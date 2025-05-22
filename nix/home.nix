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
  ];

  home.file = {
    ".config/neofetch/config.conf".source = ./dotfiles/misc/neofetch.conf;
    ".config/yabai/yabairc".source        = ./dotfiles/misc/yabai.conf;
    ".config/yadm/bootstrap".source       = ./dotfiles/misc/yadm-bootstrap.conf;
    ".config/yadm/encrypt".source         = ./dotfiles/misc/yadm-encrypt.conf;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
