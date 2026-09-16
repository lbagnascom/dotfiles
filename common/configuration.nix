{ pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "America/Argentina/Buenos_Aires";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
      ];
    };
  };

  services.displayManager.defaultSession = "xfce";

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  users.users.lauti = {
    isNormalUser = true;
    description = "Lautaro";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [ ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    stow
    btop
    polkit_gnome
  ];

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Adwaita:dark";
    # QT_QPA_PLATFORM = "wayland;xcb";
    MOZ_ENABLE_WAYLAND = 1;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.monaspace
    nerd-fonts.adwaita-mono
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    symbola
  ];

  # Thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

  services.blueman.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Disable rootless docker start on boot
  systemd.user.services.docker = {
    wantedBy = lib.mkForce [ ];
  };

  # Disable docker.socket start on boot
  systemd.sockets.docker = {
    wantedBy = lib.mkForce [ ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";
}
