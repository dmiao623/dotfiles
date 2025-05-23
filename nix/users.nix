{ config, lib, pkgs, ... }:

{
  users.users = {
    dustinm = {
      home = "/Users/dustinm";
      shell = pkgs.zsh;
    };
  };
}
