{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "lauti";
  home.homeDirectory = "/home/lauti";
  home.stateVersion = "26.05";

  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.bash = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish --login --interactive";
        font = "monospace:size=13";
      };
      cursor = {
        blink = false;
        style = "block";
      };
      colors-dark = {
        background = "000000";
        foreground = "dadada";
        regular0 = "232a2d";
        regular1 = "e57474";
        regular2 = "8ccf7e";
        regular3 = "e5c76b";
        regular4 = "67b0e8";
        regular5 = "c47fd5";
        regular6 = "6cbfbf";
        regular7 = "b3b9b8";
        bright0 = "2d3437";
        bright1 = "ef7e7e";
        bright2 = "96d988";
        bright3 = "f4d67a";
        bright4 = "71baf2";
        bright5 = "ce89df";
        bright6 = "67cbe7";
        bright7 = "bdc3c2";
      };
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

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.file.".config/sway".source = ./sway;
  home.file.".config/starship.toml".source = ./starship/config.toml;
  home.file.".ssh/config".source = ./ssh/config;

  home.sessionVariables = {
    TEXMFAUXTREES = "/home/lauti/plp/catedra/texmf,";
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
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

  programs.noctalia = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  home.packages = with pkgs; [
    ripgrep
    fd

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
    playerctl

    # Image viewer
    feh

    # Launcher
    rofi

    # Languages
    nil
    nixd
  ];

}
