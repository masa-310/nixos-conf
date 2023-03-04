{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

let hardwareConfigPath = ../. + "/${hostname}/hardware-configuration.nix";
    homeConfigPath = ../. + "/${hostname}/configuration.nix";
in {
  nixosConfigurations = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {};
    modules = [
      ../../system
      hardwareConfigPath
    ];
  };
  homeConfigurations =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit dotfile-path hostname system; };
      modules = [
        ../../home
        ./configuration.nix
        homeConfigPath
      ];
    };
}
