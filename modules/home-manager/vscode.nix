{ pkgs, ... }:

{
  home.packages = with pkgs.vscode-extensions; [
    bradlc.vscode-tailwindcss
    dbaeumer.vscode-eslint
    editorconfig.editorconfig
    esbenp.prettier-vscode
    jebbs.plantuml
    jnoortheen.nix-ide
    #ms-playwright.playwright
    #oracle.oracle-java
    #qwtel.sqlite-viewer
    redhat.java
    redhat.vscode-yaml
    #remcohaszing.schemastore
    ritwickdey.liveserver
    rust-lang.rust-analyzer
    #rvest.vs-code-prettier-eslint
    streetsidesoftware.code-spell-checker
    tamasfe.even-better-toml
    vscjava.vscode-gradle
    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-java-test
    yzane.markdown-pdf
    yzhang.markdown-all-in-one
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      esbenp.prettier-vscode
      jebbs.plantuml
      jnoortheen.nix-ide
      #ms-playwright.playwright
      #oracle.oracle-java
      #qwtel.sqlite-viewer
      redhat.java
      redhat.vscode-yaml
      #remcohaszing.schemastore
      ritwickdey.liveserver
      rust-lang.rust-analyzer
      #rvest.vs-code-prettier-eslint
      streetsidesoftware.code-spell-checker
      tamasfe.even-better-toml
      vscjava.vscode-gradle
      vscjava.vscode-java-debug
      vscjava.vscode-java-dependency
      vscjava.vscode-java-test
      yzane.markdown-pdf
      yzhang.markdown-all-in-one
    ];
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
