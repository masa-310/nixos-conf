{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfile-path = {
      url = path:./dotfiles;
      flake = false;
    };
  };
  outputs = {self, nixpkgs, home-manager, dotfile-path, ... }: 
    let 
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      configurations = import ./hosts { inherit system config nixpkgs home-manager dotfile-path; };
      nixosConfigurations = builtins.mapAttrs (_: conf: conf.nixosConfigurations) configurations;
      homeConfigurations = builtins.mapAttrs (_: conf: conf.homeConfigurations) configurations;
    in {
      inherit nixosConfigurations homeConfigurations;
    };
}
