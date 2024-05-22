{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "horizon-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "akinsho";
        repo = "horizon.nvim";
        rev = "b4d7b1e7c3aa77aea31b9ced8960e49fd8682c47";
        hash = "sha256-X4ZUtLp7KvX5h9qTfvlCHHYAn7xdnw4DZXebf240DoI=";
      };
    })
  ];

  extraConfigLua = ''
    vim.cmd([[ colorscheme horizon ]])
    vim.cmd([[
      hi LspInlayHint guifg=#d8d8d8 guibg=#3E3D53
    ]])
  '';
}
