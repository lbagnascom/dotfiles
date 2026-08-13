{ config, pkgs, ... }:

{
  home.username = "lauti";
  home.homeDirectory = "/home/lauti";
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
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
      shell-integration = "fish";
      command = "${pkgs.fish}/bin/fish --login --interactive";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      start-docker = "sudo systemctl start docker.socket && sudo systemctl start docker && systemctl --user start docker";
    };
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lautaro Bagnasco Muguillo";
        email = "tatibagnasco@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".config/rofi".source = ./rofi;
  home.file.".config/sway".source = ./sway;
  home.file.".config/waybar".source = ./waybar;
  home.file.".config/starship.toml".source = ./starship/config.toml;
  home.file.".ssh/config".source = ./ssh/config;

  home.sessionVariables = {
    TEXMFAUXTREES = "/home/lauti/plp/catedra/texmf,";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools-extension-pack
      mechatroner.rainbow-csv
    ];
  };

  home.packages = with pkgs; [
    # Shell
    fish

    # Programs
    zed-editor
    obsidian
    spotify
    discord
    telegram-desktop
    xournalpp
    qbittorrent
    unzip
    anki-bin
    zathura
    devenv
    android-studio
    chromium
    file-roller
    zotero

    # Video
    vlc
    wdisplays

    # Audio
    pavucontrol

    # Image viewer
    feh

    # Terminal
    ghostty

    # Launcher
    rofi

    # DE
    sway
    waybar

    # Screenshots
    grim
    slurp
    swappy
    wl-clipboard

    # Notification daemon
    dunst

    # Languages
    nil
    nixd
  ];

}
