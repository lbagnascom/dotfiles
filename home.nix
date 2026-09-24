{ config, pkgs, ... }:

{
  imports = [
    ./waybar.nix
    ./rofi.nix
    ./sway.nix
    ./starship.nix
  ];

  home.username = "lauti";
  home.homeDirectory = "/home/lauti";
  home.stateVersion = "26.05";

  programs.bash.enable = true;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish --login --interactive";
      };
      cursor = {
        blink = false;
        style = "block";
      };
    };
  };
  stylix.targets.foot = {
    fonts.override.sizes.terminal = 13;
    colors.override.base00 = "000000";
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
  stylix.targets.fish.enable = false;

  programs.home-manager.enable = true;

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
    enableFishIntegration = true;
  };

  home.pointerCursor = {
    enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk.enable = true;
  stylix.targets.vscode.enable = false;
  stylix.targets.gtk.extraCss = ''
    window {
      border-radius: 0px;
    }
  '';

  qt.enable = true;

  home.file.".config/mako".source = ./mako;
  home.file.".ssh/config".source = ./ssh/config;

  home.sessionVariables = {
    TEXMFAUXTREES = "/home/lauti/plp/catedra/texmf,";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools-extension-pack
      mechatroner.rainbow-csv
    ];
  };

  programs.swaylock.enable = true;
  services.mako.enable = true;

  home.packages = with pkgs; [
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

    # File manager
    localsend
    ranger

    # Video
    vlc
    wdisplays

    # Audio
    pavucontrol
    playerctl

    # Image viewer
    feh

    # Launcher
    rofi

    # DE
    waybar

    # Screenshots & Clipboard
    grim
    slurp
    swappy
    wl-clipboard

    # Screen lock
    swayidle

    # Git
    lazygit

    # Languages
    nil
    nixd
  ];

}
