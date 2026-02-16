{ config, pkgs, ... }:

let
  texliveBundle = pkgs.texliveBasic.withPackages (ps: [
    ps.latexmk
    ps.xypic ps.lastpage
    ps.collection-mathscience
    ps.epsf ps.framed
    ps.babel-spanish
    ps.beamer ps.lkproof
  ]);
in
{
  home.username = "lauti";
  home.homeDirectory = "/home/lauti";
  home.stateVersion = "25.11";

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
      background-opacity = 0.85;
      shell-integration = "fish";
      command = "${pkgs.fish}/bin/fish --login --interactive";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
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

  home.sessionVariables = {
    TEXMFAUXTREES = "/home/lauti/plp/texmf,";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
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

    # Video
    vlc

    # Image viewer
    feh

    # Terminal
    ghostty

    # Launcher
    rofi

    # DE
    sway
    waybar

    # Notification daemon
    dunst

    # Languages
    crystal
    crystalline
    swi-prolog
    ghc
    haskellPackages.haskell-language-server
    cabal-install

    # Texlive
    texliveBundle
  ];
}
