{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./keymaps.nix
    (import ./plugins { inherit pkgs; }) 
  ];

  #package = pkgs.neovim-unwrapped.overrideAttrs (final: prev: rec {
    #version = "0.10";

    #src = pkgs.fetchFromGitHub {
      #owner = "neovim";
      #repo = "neovim";
      #rev = "v${version}";
      #hash = "sha256-CcaBqA0yFCffNPmXOJTo8c9v1jrEBiqAl8CG5Dj5YxE=";
    #};
  #});

  #colorschemes.catppuccin.enable = true;
}
