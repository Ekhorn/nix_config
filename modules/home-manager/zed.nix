{ ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = ["java" "java-eclipse-jdtls" "nix" "toml"];

    userSettings = {
      hour_format = "hour24";
      auto_update = false;

      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "One Dark";
      };
      soft_wrap = "editor_width";
    };
  };
}
