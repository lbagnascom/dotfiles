{ lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      terminal = "foot";
      menu = "rofi -show drun -theme ~/.config/rofi/launcher/config.rasi";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          repeat_delay = "250";
          repeat_rate = "40";
        };
        "type:touchpad" = {
          tap = "enabled";
          tap_button_map = "lrm";
          natural_scroll = "enabled";
          dwt = "enabled";
          dwtp = "enabled";
          scroll_method = "two_finger";
        };
      };
      window = {
        commands =
          let
            floatingApp = app_id: {
              criteria = {
                app_id = app_id;
              };
              command = "floating enable, move position center";
            };
            floatingThunarTitle = title: {
              criteria = {
                app_id = "thunar";
                title = "File Operation Progress";
              };
              command = "floating enable, move position center";
            };
          in

          [
            (floatingApp "wdisplays")
            (floatingApp "pavucontrol")
            (floatingApp "blueman-manager")
            (floatingApp "nm-connection-editor")
            (floatingThunarTitle "File Operation Progress")
            (floatingThunarTitle "Confirm *")
            (floatingThunarTitle "Properties")
            (floatingThunarTitle "Rename *")
            (floatingThunarTitle "Create *")
            (floatingThunarTitle "Error *")
            (floatingThunarTitle "Question *")
            (floatingThunarTitle "Warning *")
          ];
      };

      floating = {
        modifier = "Mod4";
      };

      bars = [
        { command = "waybar"; }
      ];

      startup = [
        { command = "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"; }
        {
          command = ''
            swayidle -w \
                        timeout 300 'swaylock -f -c 1E2127' \
                        timeout 600 'swaymsg "output * dpms off"' \
                        resume 'swaymsg "output * dpms on"' \
                        before-sleep 'swaylock -f' '';
        }
        { command = ''swaymsg "workspace 1; exec firefox"''; }
      ];

      keybindings =
        let
          mod = "Mod4";
        in
        {
          # Basics
          "${mod}+Return" = "exec foot";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec rofi -show drun -theme ~/.config/rofi/launcher/config.rasi";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" = "exec ~/.config/rofi/powermenu/powermenu.sh";

          # Moving focus (vim keys)
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          # Moving focus (arrow keys)
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # Moving windows (vim keys)
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          # Moving windows (arrow keys)
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          # Layout
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          # Resize mode
          "${mod}+r" = "mode resize";
        };

      modes = {
        resize = {
          h = "resize shrink width 30px";
          j = "resize grow height 30px";
          k = "resize shrink height 30px";
          l = "resize grow width 30px";
          Left = "resize shrink width 30px";
          Down = "resize grow height 30px";
          Up = "resize shrink height 30px";
          Right = "resize grow width 30px";
          Return = "mode default";
          Escape = "mode default";
        };
      };
    };

    extraConfig = ''
      default_border pixel 1
      hide_edge_borders smart
      default_floating_border normal
      smart_borders on

      # Media keys (locked: work on lock screen too)
      bindsym --locked XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym --locked XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
      bindsym --locked XF86AudioPlay exec playerctl play-pause
      bindsym --locked XF86AudioNext exec playerctl next
      bindsym --locked XF86AudioPrev exec playerctl previous
      bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+

      # Screenshots
      bindsym Print exec grim -g "$(slurp)" - | wl-copy
      bindsym Print+Shift exec grim -g "$(slurp)" - | swappy -f -

      include /etc/sway/config.d/*
    '';
  };

}
