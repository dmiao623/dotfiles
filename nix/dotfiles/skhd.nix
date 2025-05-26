{ config, lib, pkgs, ... }:

let
  yabaiBin = "/opt/homebrew/bin/yabai";
in
{
  services.skhd = {
    enable = true;

    config = ''
      alt - j : ${yabaiBin} -m window --focus south
      alt - k : ${yabaiBin} -m window --focus north
      alt - h : ${yabaiBin} -m window --focus west
      alt - l : ${yabaiBin} -m window --focus east

      shift + alt - r : ${yabaiBin} -m space --rotate 270
      shift + alt - y : ${yabaiBin} -m space --mirror y-axis
      shift + alt - x : ${yabaiBin} -m space --mirror x-axis
      shift + alt - t : ${yabaiBin} -m window --toggle float --grid 4:4:1:1:2:2

      shift + alt - m : ${yabaiBin} -m window --toggle zoom-fullscreen
      shift + alt - e : ${yabaiBin} -m space --balance

      shift + alt - j : ${yabaiBin} -m window --swap south
      shift + alt - k : ${yabaiBin} -m window --swap north
      shift + alt - h : ${yabaiBin} -m window --swap west
      shift + alt - l : ${yabaiBin} -m window --swap east

      ctrl + alt - j : ${yabaiBin} -m window --warp south
      ctrl + alt - k : ${yabaiBin} -m window --warp north
      ctrl + alt - h : ${yabaiBin} -m window --warp west
      ctrl + alt - l : ${yabaiBin} -m window --warp east

      shift + alt - p : ${yabaiBin} -m window --space prev
      shift + alt - n : ${yabaiBin} -m window --space next

      shift + alt - 0x12 : ${yabaiBin} -m window --space 1
      shift + alt - 0x13 : ${yabaiBin} -m window --space 2
      shift + alt - 0x14 : ${yabaiBin} -m window --space 3
      shift + alt - 0x15 : ${yabaiBin} -m window --space 4
      shift + alt - 0x17 : ${yabaiBin} -m window --space 5
      shift + alt - 0x16 : ${yabaiBin} -m window --space 6
      shift + alt - 0x1A : ${yabaiBin} -m window --space 7
      shift + alt - 0x1C : ${yabaiBin} -m window --space 8
      shift + alt - 0x19 : ${yabaiBin} -m window --space 9
      shift + alt - 0x1D : ${yabaiBin} -m window --space 10
    '';
  };
}
