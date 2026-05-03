{ ... }:

{
  imports = [
    ./colorscheme.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    ./cmp.nix
    ./gitsigns.nix
    ./comment.nix
    ./indent-blankline.nix
    ./which-key.nix
    ./vimtex.nix
    ./oil-tree.nix
    ./cilantro.nix
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}
