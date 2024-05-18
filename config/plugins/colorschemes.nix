{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "horizon-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "LunarVim";
        repo = "horizon.nvim";
        rev = "f7c758f0ebd47a72dd2832a8744340e72dad62f8";
        hash = "sha256-KkjHPjcKBkW3BtIGc9kPxA5GBKr2/B6ULoEK5VSCpe8=";
      };
    })
  ];

  extraConfigLua = ''
    vim.cmd([[ colorscheme horizon ]])
    vim.cmd([[
      hi LspInlayHint guifg=#d8d8d8 guibg=#3a3a3a
    ]])
  '';
}
