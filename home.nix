{ config, pkgs, ... }:

{
  home.username = "lauti";
  home.homeDirectory = "/home/lauti";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs-desktop = "sudo nixos-rebuild switch --flake ~/dotfiles#b360m";
      nrs-laptop = "sudo nixos-rebuild switch --flake ~/dotfiles#thinkpad";
      la = "ls -lA";
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Everblush";
      background = "000000";
      shell-integration-features = "no-cursor";
      cursor-style-blink = false;
      window-decoration = "server";
      font-size = 13;
      background-opacity = 0.85;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Lautaro Bagnasco Muguillo";
        email = "tatibagnasco@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  home.file.".config/rofi".source = ./rofi;
  home.file.".config/sway".source = ./sway;
  home.file.".config/waybar".source = ./waybar;
  home.file.".config/zed".source = ./zed;
  home.file.".ssh/config".source = ./ssh/config;

  home.packages = with pkgs; [
    bat
  ];
}
