{
  description = "A flake to install quickshell";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      # Ensure consistency of dependencies
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, quickshell, ... }:
    let
      system = "x86_64-linux"; # Change to your desired system
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = quickshell.packages.${system}.default;

      apps.${system}.default = {
        type = "app";
        program = "${quickshell.packages.${system}.default}/bin/quickshell";
      };

      # Optional: expose a dev shell if needed
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ quickshell.packages.${system}.default ];
      };
    };
}

