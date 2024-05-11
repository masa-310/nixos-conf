# extra = {
#   inherit dotfile nixos-hardware xmonad-config
# }
{ system, home-manager, pkgs, unstable, extra }:

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
            nixosConfigurations = unstable.lib.nixosSystem {
              inherit system;
              specialArgs = {
                extra = extra // { inherit system hostname; pkg-path=pkgs.outPath; unstable-path=unstable.outPath;};
              };
              modules = [
                ../system
                systemConfigPath
                hardwareConfigPath
              ];
            };
            homeConfigurations =
              home-manager.lib.homeManagerConfiguration {
                pkgs = unstable;
                extraSpecialArgs = {
                  extra = extra // { inherit system unstable hostname; };
                };
                modules = [
                  ../home
                  homeConfigPath
                ];
              };
          };
}) hosts)
