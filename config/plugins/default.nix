{ pkgs, volar-package, vuets, vuels,... }: {
  imports = [
    ./colorschemes.nix
    ./core.nix
    ./editing.nix
    ./file-explorer.nix
    ./formatter.nix
    ./languages-specific.nix
    (import ./lsp.nix { inherit pkgs volar-package vuels vuets; })
    ./telescope.nix
    ./terminals.nix
    ./ui.nix
  ];
}
