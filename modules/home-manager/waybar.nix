{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      primary = {
        layer = "top";
        position = "top";
        spacing = 6;

        modules-left = ["hyprland/workspaces" "tray"];
        modules-center = ["group/local"];
        modules-right = [
          "group/sound"
          "group/connectivity"
          "group/hardware"
          "battery"
        ];

        "hyprland/workspaces" = {
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };

        "group/local" = {
          orientation = "inherit";
          modules = ["clock" "custom/weather"];
        };

        "clock" = {
          interval = 1;
          format = "{:%a, %b %d, %H:%M:%S}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-scroll-up" = ["tz_up" "shift_up"];
            "on-scroll-down" = ["tz_down" "shift_down"];
          };
        };

        "custom/weather" = {
          format = "{}";
          return-type = "json";
          exec = "~/.config/waybar/scripts/weather.sh";
          interval = 120;
          "on-click" = "firefox https://wttr.in/$(cat .config/waybar/scripts/location.txt)";
        };

        "group/sound" = {
          orientation = "inherit";
          modules = ["group/audio" "pulseaudio#mic"];
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "transition-left-to-right" = false;
          };
          modules = ["pulseaudio" "pulseaudio/slider"];
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 140;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            default = "";
            headphone = "";
            speaker = "";
            headset = "";
            "hands-free" = "";
            portable = "";
            car = "";
            phone = "";
          };
        };

        "pulseaudio#mic" = {
          format = " {format_source}";
          "format-muted" = " {format_source}";
          tooltip = false;
        };

        "group/connectivity" = {
          orientation = "inherit";
          modules = ["group/network" "bluetooth" "bluetooth#status"];
        };

        "group/network" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "transition-left-to-right" = false;
          };
          modules = ["network" "network#essid"];
        };

        "network#essid" = {
          "format-wifi" = "{essid}";
          "tooltip-format" = "{ipaddr}";
          "on-click" = "wl-copy $(ip route get 8.8.8.8 | sed -n 's/.*src \$[^\\ ]*\$.*/\\1/p')";
        };

        "network" = {
          interval = 5;
          "format-wifi" = " {bandwidthDownBits}";
          "format-ethernet" = " {bandwidthDownBits}";
          "format-disconnected" = "  ???";
          "tooltip-format" = "Signal: {signalStrength}%";
        };

        "bluetooth" = {
          "format-on" = " on ";
          "format-off" = " off";
          "format-disabled" = "";
          "format-connected" = "<b></b>";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "rofi-bluetooth";
          "on-click-right" = "rfkill toggle bluetooth";
        };

        "bluetooth#status" = {
          "format-on" = "";
          "format-off" = "";
          "format-disabled" = "";
          "format-connected" = "<b>{num_connections}</b>";
          "format-connected-battery" = "<b>{device_battery_percentage}%</b>";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        "group/hardware" = {
          orientation = "inherit";
          modules = ["group/disk" "memory" "cpu"];
        };

        "cpu" = {
          interval = 2;
          format = " {usage}%";
        };

        "memory" = {
          interval = 2;
          format = "{used:0.1f} GB";
          "tooltip-format" = "{used:0.1f} / {total:0.1f}";
        };

        "group/disk" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 300;
            "transition-left-to-right" = true;
          };
          modules = ["disk#disk1" "disk#disk2"];
        };

        "disk#disk1" = {
          interval = 30;
          format = " {specific_free:0.1f} GB";
          unit = "GB";
          tooltip = false;
        };

        "disk#disk2" = {
          interval = 30;
          format = "/ {specific_total:0.1f} GB";
          unit = "GB";
          tooltip = false;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["" "" "" "" ""];
          tooltip = true;
        };
      };
    };

    style = ''
      /* -----------------------------------------------------
      * General
      * ----------------------------------------------------- */

      * {
        font-family: "Unifont";
        font-size: 16px;
        border: none;
        border-radius: 0px;
        font-weight: bold;
      }

      window#waybar {
        background-color: rgba(56, 60, 74, 0.8);
        border-bottom: 2px solid rgba(72, 75, 85, 0.8);
        color: white;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar > box.horizontal {
        padding: 4px;
        padding-bottom: 6px;
      }

      box.horizontal > widget {
        background-color: rgba(56, 60, 74, 1);
        border-radius: 10px;
      }

      /* -----------------------------------------------------
      * Tooltips
      * ----------------------------------------------------- */

      tooltip {
        border-radius: 10px;
        background-color: rgba(56, 60, 74, 1);
        padding: 20px;
        margin: 0px;
      }

      tooltip label {
        color: white;
      }

      /* -----------------------------------------------------
      * Modules
      * ----------------------------------------------------- */

      .modules-left {
      }

      .modules-center {
      }

      .modules-right {
      }

      /* -----------------------------------------------------
      * Workspaces
      * ----------------------------------------------------- */

      #workspaces {
        padding: 0px 1px;
        border: 0px;
      }

      #workspaces button {
        color: white;
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        transition: all 0.3s ease-in-out;
        opacity: 0.4;
      }

      #workspaces button.active {
        background-color: rgba(45, 48, 60, 1);
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity: 0.8;
      }

      #workspaces button:hover {
        background-color: rgb(19, 20, 26);
        border-radius: 15px;
      }

      /* -----------------------------------------------------
      * Tray
      * ----------------------------------------------------- */

      #tray {
        padding: 0 9px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      /* -----------------------------------------------------
      * Local Group - Clock / Weather
      * ----------------------------------------------------- */

      #clock,
      #custom-weather {
        padding: 0 9px;
      }

      /* -----------------------------------------------------
      * Sound Group - Pulseaudio
      * ----------------------------------------------------- */

      #pulseaudio,
      #pulseaudio.mic,
      #pulseaudio-sider {
        padding: 0 9px;
      }

      #pulseaudio {
        min-width: 60px;
      }

      #pulseaudio-slider {
        min-width: 60px;
      }
      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }
      #pulseaudio-slider trough {
        min-width: 10px;
        border-radius: 5px;
        background-color: black;
      }
      #pulseaudio-slider highlight {
        min-height: 10px;
        min-width: 10px;
        border-radius: 5px;
        background-color: green;
      }

      #pulseaudio.muted {
        background-color: @backgrounddark;
      }

      /* -----------------------------------------------------
      * Connectivity Group - Network / Bluetooth
      * ----------------------------------------------------- */

      #network,
      #bluetooth {
        padding: 0 9px;
      }

      box#network > widget > #network {
        min-width: 102px;
      }

      #bluetooth,
      #bluetooth.on,
      #bluetooth.connected {
        /*color: #2a91c9;*/
      }

      #bluetooth.off {
        background-color: transparent;
      }

      /* -----------------------------------------------------
      * Hardware Group
      * ----------------------------------------------------- */

      box#hardware {
      }

      .disk1,
      #memory,
      #cpu {
        padding: 0 9px;
      }

      .disk2 {
        padding-right: 10px;
      }

      #memory,
      #cpu {
        min-width: 60px;
      }

      /* -----------------------------------------------------
      * Battery
      * ----------------------------------------------------- */

      #battery {
        padding: 0 9px;
      }

      #battery.charging,
      #battery.plugged {
        color: @textcolor2;
      }

      @keyframes blink {
        to {
          color: orange;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
  };
}
