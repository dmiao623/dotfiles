{ config, lib, pkgs, ... }:

let
  dotfiles = ./dotfiles;
in
{
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    "${dotfiles}/bat.nix"
    "${dotfiles}/fzf.nix"
    "${dotfiles}/git.nix"
    "${dotfiles}/kitty.nix"
    "${dotfiles}/qutebrowser.nix"
    "${dotfiles}/skhd.nix"
    "${dotfiles}/zsh.nix"
  ];

  home.file = {
    ".config/neofetch/config.conf".source = "${dotfiles}/misc/neofetch.conf";
    ".config/yabai/yabairc".source        = "${dotfiles}/misc/yabai.conf";
    ".config/yadm/bootstrap".source       = "${dotfiles}/misc/yadm-bootstrap.sh";
    ".config/yadm/encrypt".source         = "${dotfiles}/misc/yadm-encrypt.conf";
    ".hushlogin".source                   = "${dotfiles}/misc/hushlogin";
    ".qutebrowser/blocked-hosts".source   = "${dotfiles}/private/qutebrowser-blocked-hosts";
    ".qutebrowser/quickmarks".source      = "${dotfiles}/private/qutebrowser-quickmarks";
    ".simplebarrc".source                 = "${dotfiles}/misc/simplebar.json";
  };

  home.sessionPath = [
    "/usr/local/smlnj/bin"
  ];
}
