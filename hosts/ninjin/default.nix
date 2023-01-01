{ system, nixpkgs, home-manager, dotfile-path, hostname, ... }:

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
    let pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit dotfile-path hostname; };
      modules = [
        ../../home
        ./configuration.nix
      ];
    };
}
