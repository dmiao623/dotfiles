{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName  = "dustinm";
    userEmail = "dustinmmiao@gmail.com";

    ignores = [
      ".DS_Store"
      ".claude/"
      ".vscode/"
    ];

    riff = {
      enable = true;
    };
  };
}
