{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          color = "rgb(000000)";
        }
      ];

      input-field = [
        {
          size = "200, 50";
          outline_thickness = 2;
          dots_size = 0.1;
          dots_spacing = 0.3;
          outer_color = "rgb(255, 255, 255)";
          inner_color = "rgb(0, 0, 0)";
          font_family = "Unifont";
          font_color = "rgb(255, 255, 255)";
          font_size = 14;
          rounding = 0;

          placeholder_text = "<i>Input password...</i>";
          check_color = "rgb(204, 136, 34)";

          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        { # Clock
          monitor = "";
          text = "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +\"%H:%M | %a *
        %b | %Y-%m-%d\")\"";
          font_family = "Unifont";
          font_size = 12;

          position = "0, 0";
          halign = "center";
          valign = "top";
        }
      ];
    };
  };
}
