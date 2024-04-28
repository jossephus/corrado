{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "hbac";
      src = pkgs.fetchFromGitHub {
        owner = "axkirillov";
        repo = "hbac.nvim";
        rev = "e2e8333aa56ef43a577ac3a2a2e87bdf2f0d4cbb";
        hash = "sha256-7+e+p+0zMHPJjpnKNkL7QQHZJGQ1DFZ6fsofcsVNXaY=";
      };
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-geez";
      src = pkgs.fetchFromGitHub {
        owner = "jossephus";
        repo = "vim-geez";
        rev = "41044d848b382bcf48be5bcfc10c93bd145b2ff7";
        hash = "sha256-NcLoOKMPNgGxBexdR3W9yJNU0p7ayveJJ+tItqF1L7M=";
      };
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-silicon";
      src = pkgs.fetchFromGitHub {
        owner = "segeljakt";
        repo = "vim-silicon";
        rev = "4a93122ae2139a12e2a56f064d086c05160b6835";
        hash = "sha256-8pCHtApD/xXav2UBVOVhkaHg3YS4aNCZ73mog04bYuA=";
      };
      buildInputs = [pkgs.silicon];
    })

    treesj
    nerdcommenter
    lexima-vim
    vim-visual-multi
  ];

  plugins = {
    rainbow-delimiters = {
      enable = true;
    };
    navic = {
      enable = true;
    };
    surround = {
      enable = true;
    };
    ts-autotag = {
      enable = true;
    };
  };

  extraConfigLua = ''
    require("hbac").setup({
        autoclose = true,
        threshold = 4,
    })
    require('treesj').setup({})

    vim.cmd([[
      function! ToggleGeezKeyboard()
         if &keymap !=# "geez"
             set keymap=geez
         else
             set keymap=
         endif
      endfunction

      nnoremap <Leader>g :call ToggleGeezKeyboard()<cr>
      inoremap <Leader>g <ESC>:call ToggleGeezKeyboard()<cr>i
    ]])

    vim.keymap.set("n", "<Leader>ss", ':Silicon /mnt/c/Users/25191/Downloads/Screenshots/<cr>')
      vim.g.silicon = {
        theme = '1337',
        font = 'GoMono Nerd Font Mono',
        background = '#AAAAFF',
        --shadow_color = '#555555',
        --line_pad = 2,
        --pad_horiz = 80,
        --pad_vert = 100,
        --shadow_blur_radius = 0,
        --shadow_offset_x = 0,
        --shadow_offset_y = 0,
        --line_number = true,
        --round_corner = true,
        --window_controls = true,
      }

  '';
}
