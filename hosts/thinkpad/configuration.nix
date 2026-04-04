{ config, pkgs, ... }:

{
  networking.hostName = "thinkpad";

  environment.variables = {
    WLR_RENDER_NO_EXPLICIT_SYNC = 1;
  };

  nix.settings.access-tokens = [ "!include /etc/nixos/github-token" ];
}
