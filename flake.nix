{
  description = "Vale prose rules and regression fixtures";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      eachSystem = nixpkgs.lib.genAttrs systems;
      package = system: (import ./overlay.nix nixpkgs.legacyPackages.${system} { }).vale-styles;
    in
    {
      overlays.default = import ./overlay.nix;
      packages = eachSystem (system: {
        default = package system;
      });
      checks = eachSystem (system: {
        fixtures = package system;
      });
      formatter = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.writeShellApplication {
          name = "prose-style-format";
          runtimeInputs = [ pkgs.nixfmt ];
          text = ''
            exec nixfmt "$@" flake.nix overlay.nix
          '';
        }
      );
    };
}
