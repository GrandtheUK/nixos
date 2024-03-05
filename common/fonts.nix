{ 
  description = "A flake for impact font";

  inputs.nixpkgs = github:NixOS/nixpkgs/nixos-23.11;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system}
      packageName = "impact";
      src = pkgs.fetchurl {
        url = "https://befonts.com/wp-content/uploads/2022/09/impact-font.zip";
        hash = "5e8bb5d45990174c87dae72f6bfcf188c4538f8e78bf18ca537110f994c8f281";
      }
        
    in {
      packages.impact = pkgs.stdenv.mkDerivation {
          version = "0.1.0";

          unpackPhase = ''
            unzip '$src'
          '';

          buildInputs = [pkgs.unzip];
          setSourceRoot = "sourceRoot=`pwd`";

          installPhase = ''
            mkdir -p $out/share/fonts
            mkdir -p $out/share/fonts/truetype
            mv impact.ttf $out/share/fonts/truetype/
          '';
        };
      defaultPackage = self.packages.${system}.${packageName};
    };
  );

}