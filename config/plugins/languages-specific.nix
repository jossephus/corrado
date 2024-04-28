{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    neodev-nvim
  ];

  extraConfigLua = ''
    require('neodev').setup()
  '';

  plugins = {
    crates-nvim = {
      enable = true;

      extraOptions = {
        null_ls = {
          enabled = true;
          name = "crates.nvim";
        };
      };
    };
  };
}
