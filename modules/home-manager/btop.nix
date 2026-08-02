{ lib, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "theme";
    };
    themes =
      let
        metrics = [
          "temp"
          "cpu"
          "cached" # Mem/Disk cached meter
          "available" # Mem/Disk available meter
          "used" # Mem/Disk used meter
          "download"
          "upload"
        ];
        # horizon theme gradient colors
        metricGradients = lib.join "\n" (
          map (m: ''
            theme[${m}_start]="#27D796"
            theme[${m}_mid]="#FAC29A"
            theme[${m}_end]="#E95678"
          '') metrics
        );
      in
      {
        theme = ''
          theme[main_bg]="#00"
          theme[main_fg]="#cc"
          theme[title]="#ee"
          theme[hi_fg]="#b54040"
          theme[selected_bg]="#6a2f2f"
          theme[selected_fg]="#ee"
          theme[inactive_fg]="#40"
          theme[graph_text]="#60"
          theme[meter_bg]="#40"
          theme[proc_misc]="#0de756"
          theme[cpu_box]="#556d59"
          theme[mem_box]="#6c6c4b"
          theme[net_box]="#5c588d"
          theme[proc_box]="#805252"
          theme[div_line]="#30"
          theme[proc_pause_bg]="#b54040"
          theme[proc_follow_bg]="#4040b5"
          theme[proc_banner_bg]="#7b407b"
          theme[proc_banner_fg]="#ee"
          theme[followed_bg]="#4040b5"
          theme[followed_fg]="#ee"

          # Mem/Disk free meter
          theme[free_start]="#E95678"
          theme[free_mid]="#FAC29A"
          theme[free_end]="#27D796"
        ''
        + metricGradients;
      };
  };
}
