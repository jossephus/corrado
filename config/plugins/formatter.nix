{pkgs, ...}: {
  plugins = {
    conform-nvim = {
      enable = true;

      formattersByFt = {
        javascript = [["prettier"]];
        typescript = [["prettierd"]];
      };

      settings = {
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
      };
    };
  };
}
