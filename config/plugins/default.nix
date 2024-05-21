{ pkgs, ... }: {
  imports = [
    ./colorschemes.nix
    ./core.nix
    ./editing.nix
    ./file-explorer.nix
    ./formatter.nix
    ./languages-specific.nix
    (import ./lsp.nix { inherit pkgs; })
    ./telescope.nix
    ./terminals.nix
    ./ui.nix
  ];
}
