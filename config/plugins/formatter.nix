{pkgs, ...}: {
  plugins = {
    conform-nvim = {
      enable = true;

      formattersByFt = {
        javascript = [["prettier"]];
        typescript = [["prettierd"]];
      };

      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
    };
  };
}
