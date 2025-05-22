{ config, pkgs, lib, ... }:

{
  services.skhd = {
    enable = true;

    config = ''
      alt - j : /opt/homebrew/bin/yabai -m window --focus south
      alt - k : /opt/homebrew/bin/yabai -m window --focus north
      alt - h : /opt/homebrew/bin/yabai -m window --focus west
      alt - l : /opt/homebrew/bin/yabai -m window --focus east

      shift + alt - r : /opt/homebrew/bin/yabai -m space --rotate 270
      shift + alt - y : /opt/homebrew/bin/yabai -m space --mirror y-axis
      shift + alt - x : /opt/homebrew/bin/yabai -m space --mirror x-axis
      shift + alt - t : /opt/homebrew/bin/yabai -m window --toggle float --grid 4:4:1:1:2:2

      shift + alt - m : /opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen
      shift + alt - e : /opt/homebrew/bin/yabai -m space --balance

      shift + alt - j : /opt/homebrew/bin/yabai -m window --swap south
      shift + alt - k : /opt/homebrew/bin/yabai -m window --swap north
      shift + alt - h : /opt/homebrew/bin/yabai -m window --swap west
      shift + alt - l : /opt/homebrew/bin/yabai -m window --swap east

      ctrl + alt - j : /opt/homebrew/bin/yabai -m window --warp south
      ctrl + alt - k : /opt/homebrew/bin/yabai -m window --warp north
      ctrl + alt - h : /opt/homebrew/bin/yabai -m window --warp west
      ctrl + alt - l : /opt/homebrew/bin/yabai -m window --warp east

      shift + alt - p : /opt/homebrew/bin/yabai -m window --space prev
      shift + alt - n : /opt/homebrew/bin/yabai -m window --space next

      shift + alt - 0x12 : /opt/homebrew/bin/yabai -m window --space 1
      shift + alt - 0x13 : /opt/homebrew/bin/yabai -m window --space 2
      shift + alt - 0x14 : /opt/homebrew/bin/yabai -m window --space 3
      shift + alt - 0x15 : /opt/homebrew/bin/yabai -m window --space 4
      shift + alt - 0x17 : /opt/homebrew/bin/yabai -m window --space 5
      shift + alt - 0x16 : /opt/homebrew/bin/yabai -m window --space 6
      shift + alt - 0x1A : /opt/homebrew/bin/yabai -m window --space 7
      shift + alt - 0x1C : /opt/homebrew/bin/yabai -m window --space 8
      shift + alt - 0x19 : /opt/homebrew/bin/yabai -m window --space 9
      shift + alt - 0x1D : /opt/homebrew/bin/yabai -m window --space 10
    '';
  };
}
