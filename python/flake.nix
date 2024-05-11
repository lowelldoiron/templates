{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python3.withPackages
            (p:
              with p; [
                pip

                pwntools
              ]))

          pkgs.hello
        ];

        shellHook = ''
          python -m venv .venv
          source ./.venv/bin/activate
          $EDITOR ./
        '';
      };
    });
}