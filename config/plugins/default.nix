{ pkgs, volar-package, ... }: {
  imports = [
    ./colorschemes.nix
    ./core.nix
    ./editing.nix
    ./file-explorer.nix
    ./formatter.nix
    ./languages-specific.nix
    (import ./lsp.nix { inherit pkgs volar-package; })
    ./telescope.nix
    ./terminals.nix
    ./ui.nix
  ];
}
