{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

{
  nixosConfigurations = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {};
    modules = [
      ../../system
      ./hardware-configuration.nix
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
