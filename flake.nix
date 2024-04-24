{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
        url = "github:jossephus/nixvim?ref=add-component-to-neotree";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, flake-utils }: 
  flake-utils.lib.eachDefaultSystem(system: 
    let 
       pkgs = nixpkgs.legacyPackages.${system};
       nixvim' = nixvim.legacyPackages.${system};
       nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            # inherit (inputs) foo;
          };
        };
       nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in {
      packages = {
        default = nvim;
      };

      app = {
        default = nvim;
      };
    }
  );
}
