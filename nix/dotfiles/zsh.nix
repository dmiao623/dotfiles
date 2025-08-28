{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;

    dirHashes = {
      dc = "$HOME/Documents";
      dn = "$HOME/Downloads";
      dr = "$HOME/My Drive";
      dt = "$HOME/Desktop";
    };

    history = {
      append                = true;
      save                  = 1000;
      size                  = 999;
      findNoDups            = true;
      saveNoDups            = false;
      ignoreDups            = true;
      ignoreSpace           = false;
      expireDuplicatesFirst = true;
    };

    localVariables = {
      PROMPT = "$ ";
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      VISUAL = "nvim";
      EDITOR = "nvim";
      PS1 = "$ ";
      DR = "/Users/dustinm/My Drive/Academics/Carnegie Mellon University/Current Courses";
    };

    shellAliases = {
      la = ''
        eza --all --color=always --grid --icons=always
      '';

      ls = ''
        eza --color=always --grid --icons=always
      '';

      tree = ''
        eza --tree --color=always
      '';

      l = ''
        cd "$(command lf -print-last-dir "$@")"
      '';

      ".." = ''
        cd ..
      '';
    };

    syntaxHighlighting = {
      enable = true;
    };

    initContent = lib.mkOrder 1500 ''
      cd() {
        if ! builtin cd "$@"; then
          return 1
        fi
        echo "Current Directory: $(pwd)"
        ls
      }

      source ~/nix/dotfiles/private/api_keys.sh
      source "/Users/dustinm/Google Drive/My Drive/Academics/Carnegie Mellon University/Miscellaneous/TeX Templates/β/scripts/ttex.sh"
      
      neofetch
    '';

  };
}
