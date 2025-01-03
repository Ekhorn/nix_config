{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      comment-nvim
      luasnip
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      conform-nvim
      fidget-nvim
      gitsigns-nvim
      lazy-nvim
      mason-lspconfig-nvim
      mason-tool-installer-nvim
      mason-nvim
      mini-nvim
      neodev-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      telescope-nvim
      todo-comments-nvim
      tokyonight-nvim
      vim-sleuth
      which-key-nvim
    ];
  };
}
