{ pkgs, ... }:

{
  imports = [
    ./nixvim/options.nix
    ./nixvim/keymaps.nix
    ./nixvim/plugins
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
