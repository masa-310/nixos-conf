{ system, nixpkgs, pkgs, home-manager, dotfile-path, ... }:

let dir = builtins.readDir ./.;
    hosts = builtins.foldl' (
      acc: name:
        let type = builtins.getAttr name dir;
        in if type == "directory" then acc++[name] else acc
    ) [] (builtins.attrNames dir);
in builtins.listToAttrs (builtins.map (hostname: {
  name  = hostname;
  value = let homeConfigPath = ./. + "/${hostname}/home-configuration.nix";
              systemConfigPath = ./. + "/${hostname}/system-configuration.nix";
              hardwareConfigPath = ./. + "/${hostname}/hardware-configuration.nix";
          in {
            nixosConfigurations = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit hostname; };
              modules = [
                ../system
                systemConfigPath
                hardwareConfigPath
              ];
            };
            homeConfigurations =
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit dotfile-path hostname system; };
                modules = [
                  ../home
                  homeConfigPath
                ];
              };
          };
}) hosts)
