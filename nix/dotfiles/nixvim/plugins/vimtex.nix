{ lib, ... }:

{
  programs.nixvim = {
    globals = {
      tex_flavor           = "latex";
      vimtex_view_method   = lib.mkForce "skim";
      vimtex_quickfix_mode = 0;
      tex_conceal          = "abdmg";
    };

    opts.conceallevel = 1;

    plugins.vimtex = {
      enable = true;
      texlivePackage = null; # texliveFull is installed at the system level in flake.nix
    };
  };
}
