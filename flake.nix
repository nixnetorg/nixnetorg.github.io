{
  description = "nixnet.org static site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, config, ... }: {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "nixnet-site";
          src = ./src;

          nativeBuildInputs = [ pkgs.dart-sass ];

          buildPhase = ''
            mkdir -p $out/styles
            cp index.html $out/
            cp -r res $out/res
            sass styles/main.scss $out/styles/main.css --no-source-map
          '';

          installPhase = "true";
        };

        apps.default = {
          type = "app";
          program = toString (pkgs.writeShellScript "preview" ''
            xdg-open "file://${config.packages.default}/index.html"
          '');
        };

        devShells.default = pkgs.mkShell {
          packages = [ pkgs.dart-sass ];
        };
      };
    };
}
