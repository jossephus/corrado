{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      #url = "github:nix-community/nixvim";
      url = "flake:localnixvim";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        volar-package = pkgs.vscode-extensions.vue.volar;

        vuets = pkgs.buildNpmPackage rec {
          name = "@vue/typescript-plugin";
          version = "2.0.19";
          src = pkgs.fetchurl {
              url = "https://registry.npmjs.org/@vue/typescript-plugin/-/typescript-plugin-${version}.tgz";
              hash = "sha256-mWs8JPxWdQtaW30yVKRJsv70bZicz1HBVRwa5QSWcTE=";
          };
          npmDepsHash = "sha256-OEMnImWpwNbAElpHRtW4kDn8WTfR027IUX1BVKhI+40=";
          dontNpmBuild = true;
          postPatch = ''
            cp ${./others/vue/typescript-plugin/package-lock.json} package-lock.json
          '';
        };

        vuels = pkgs.buildNpmPackage rec {
            name = "@vue/language-server";
            version = "2.0.19";
            src = pkgs.fetchurl {
              url = "https://registry.npmjs.org/@vue/language-server/-/language-server-${version}.tgz";
              hash = "sha256-4BZupUu0fpKH8lN0rwOXrY3QqBcGsugzeW7ptPa4Lj4=";
            };
            postPatch = ''
              cp ${./others/vue/language-server/package-lock.json} package-lock.json
            '';
            npmDepsHash = "sha256-Y5QNmjE58FeelGhSK3qHAMZs3xL+/1fHyNGL9bJElgE=";
            dontNpmBuild = true;
            meta = {
              mainProgram = "vue-language-server";
            };
        };

        #vue-typescript-plugin = pkgs.buildNpmPackage rec {
          #pname = "@vue/typescript-plugin";
          #version = "2.0.19";
        #};
        #volar-package = pkgs.nodePackages."@volar/vue-language-server";
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./config { inherit pkgs volar-package vuels vuets; }; # import the module directly
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
