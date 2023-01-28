{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

let path = ../. + "/${hostname}/hardware-configuration.nix";
in {
  nixosConfigurations = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {};
    modules = [
      ../../system
      path
    ];
  };
  homeConfigurations =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit dotfile-path hostname system; };
      modules = [
        ../../home
        ./configuration.nix
      ];
    };
}
