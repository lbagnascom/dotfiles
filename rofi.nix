{ config, ... }:

{
  home.file.".config/rofi/colors.rasi".text =
    let
      colors = config.lib.stylix.colors;
    in
    ''
      * {
          background:     #${colors.base00}FF;
          background-alt: #${colors.base01}FF;
          foreground:     #${colors.base05}FF;
          selected:       #${colors.base03}FF;
          active:         #${colors.base0B}FF;
          urgent:         #${colors.base08}FF;
      }
    '';

  home.file.".config/rofi/launcher/config.rasi".source = ./rofi/launcher/config.rasi;
  home.file.".config/rofi/launcher/fonts.rasi".source = ./rofi/launcher/fonts.rasi;
  home.file.".config/rofi/powermenu/config.rasi".source = ./rofi/powermenu/config.rasi;
  home.file.".config/rofi/powermenu/fonts.rasi".source = ./rofi/powermenu/fonts.rasi;
  home.file.".config/rofi/powermenu/powermenu.sh".source = ./rofi/powermenu/powermenu.sh;
  home.file.".config/rofi/screen-picker/config.rasi".source = ./rofi/screen-picker/config.rasi;
  home.file.".config/rofi/screen-picker/fonts.rasi".source = ./rofi/screen-picker/fonts.rasi;
}
