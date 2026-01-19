{ ... }:

{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    keyboard.bindings = [
      {
        key = "Back";
        mods = "Control";
        chars = "\\u0017";
      }
    ];
  };
}
