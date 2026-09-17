{ lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 20;
        spacing = 5;

        "modules-left" = [
          "sway/workspaces"
          "sway/mode"
        ];
        "modules-right" = [
          "wireplumber"
          "battery"
          "idle_inhibitor"
          "network"
          "bluetooth"
          "custom/notification"
          "tray"
          "clock"
        ];

        "sway/workspaces" = {
          "disable-scroll" = true;
          format = "{icon}";
        };

        network = {
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰀂";
          "format-disconnected" = "󰤮";
          "tooltip-format-wifi" = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-ethernet" = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-disconnected" = "Disconnected";
        };

        battery = {
          bat = "BAT0";
          format = "{icon} {capacity}%";
          "format-discharging" = "{icon} {capacity}%";
          "format-charging" = "{icon} {capacity}%";
          "format-plugged" = "";
          "format-icons" = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          "format-full" = "󰂅";
          "tooltip-format-discharging" = "{power:>1.0f}W↓ {capacity}%";
          "tooltip-format-charging" = "{power:>1.0f}W↑ {capacity}%";
          interval = 60;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        bluetooth = {
          format = "";
          "format-off" = "󰂲";
          "format-disabled" = "󰂲";
          "format-connected" = "󰂱";
          "format-no-controller" = "";
          "tooltip-format" = "Devices connected: {num_connections}";
        };

        clock = {
          timezone = "America/Argentina/Buenos_Aires";
          format = "{:%d·%m·%Y %H:%M}";
          tooltip = false;
        };

        wireplumber = {
          format = builtins.fromJSON ''"\udb81\udd7e {volume}%"'';
          "max-volume" = 100;
          "scroll-step" = 5;
        };

        tray = {
          "icon-size" = 16;
          spacing = 16;
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = builtins.fromJSON ''"\udb80\udd76"'';
            deactivated = builtins.fromJSON ''"\udb83\udfaa"'';
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          "format-icons" = {
            notification = "<span foreground='#D29922'>󰂚</span>";
            none = "<span foreground='#d0d7de'>󰂚</span>";
            "dnd-notification" = "<span foreground='#D29922'>󰂛</span>";
            "dnd-none" = "<span foreground='#d0d7de'>󰂛</span>";
            "inhibited-notification" = "<span foreground='#D29922'>󰂚</span>";
            "inhibited-none" = "<span foreground='#d0d7de'>󰂚</span>";
            "dnd-inhibited-notification" = "<span foreground='#D29922'>󰂛</span>";
            "dnd-inhibited-none" = "<span foreground='#d0d7de'>󰂛</span>";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb --skip-wait";
          "on-click" = "swaync-client -t";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
          "restart-interval" = 3;
        };
      };
    };

    style = lib.mkAfter ''
      * {
        font-size: 15px;
        padding: 0;
        margin: 0;
        border-radius: 0px;
        box-shadow: none;
      }

      #waybar {
        color: @base05;
        background-color: @base00;
      }

      #workspaces button {
        color: @base03;
        padding-left: 0.2em;
        padding-right: 0.2em;
        border: none;
      }

      #workspaces button.empty {
        color: @base01;
      }

      #workspaces button.focused {
        color: @base05;
      }

      #workspaces button.urgent {
        color: @base08;
      }

      #memory,
      #custom-platform-profile {
        padding-left: 1em;
      }

      #wireplumber,
      #battery,
      #idle_inhibitor,
      #language,
      #network,
      #bluetooth,
      #custom-notification,
      #clock,
      #tray {
        padding-right: 1em;
      }
    '';
  };
}
