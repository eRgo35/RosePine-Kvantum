{
  description = "Rose Pine theme for Kvantum";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "rosepine-kvantum";
          version = "1.0.0";

          src = ./.;

          installPhase = ''
            runHook preInstall

            mkdir -p $out/share/Kvantum/rosepine-kvantum
            cp -r rosepine-kvantum $out/share/Kvantum/rosepine-kvantum

            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "Rose Pine theme for Kvantum";
            homepage = "https://github.com/eRgo35/RosePine-Kvantum";
            license = licenses.mit;
            platforms = platforms.all;
          };
        };
      }
    );
}
