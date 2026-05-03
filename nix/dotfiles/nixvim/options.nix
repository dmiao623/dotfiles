{ ... }:

{
  programs.nixvim = {
    globals = {
      netrw_liststyle = 3;
      python_recommended_style = 0;
    };

    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      wrap = false;

      ignorecase = true;
      smartcase = true;

      termguicolors = true;
      background = "dark";
      signcolumn = "yes";

      backspace = "indent,eol,start";
      clipboard = "unnamedplus";

      splitright = true;
      splitbelow = true;

      scrolloff = 8;
      sidescrolloff = 8;

      swapfile = false;
      backup = false;
      undofile = true;

      timeout = true;
      timeoutlen = 500;
    };

    autoCmd = [
      {
        event = [ "BufRead" "BufNewFile" ];
        pattern = [ "*.c0" "*.c1" ];
        command = "set filetype=c";
      }
      {
        event = [ "BufRead" "BufNewFile" ];
        pattern = "*.fun";
        command = "set filetype=sml";
      }
    ];

    extraConfigLua = ''
      vim.opt.iskeyword:append("-")
    '';
  };
}
