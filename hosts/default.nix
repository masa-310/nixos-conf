{ system, nixpkgs, pkgs, unstable, home-manager, dotfile-path, ... }:

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
              specialArgs = { inherit hostname pkgs unstable; };
              modules = [
                ../system
                systemConfigPath
                hardwareConfigPath
              ];
            };
            # Home Mangerはunstable
            homeConfigurations =
              home-manager.lib.homeManagerConfiguration {
                pkgs = unstable;
                extraSpecialArgs = { inherit dotfile-path hostname system unstable; };
                modules = [
                  ../home
                  homeConfigPath
                ];
              };
          };
}) hosts)
