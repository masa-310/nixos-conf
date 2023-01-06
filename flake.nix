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
    xmonad-config.url = "github:masa-310/.xmonad";
    # xmonad-config.url = path:./conf/.xmonad;
  };
  outputs = {self, nixpkgs, home-manager, dotfile-path, xmonad-config, ... }: 
    let
      overlay = final: prev: { inherit xmonad-config; };
      overlays = [overlay];
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      pkgs = import nixpkgs { inherit system overlays config; };
      configurations = import ./hosts { inherit system config home-manager dotfile-path nixpkgs pkgs; };
      nixosConfigurations = builtins.mapAttrs (_: conf: conf.nixosConfigurations) configurations;
      homeConfigurations = builtins.mapAttrs (_: conf: conf.homeConfigurations) configurations;
    in {
      inherit nixosConfigurations homeConfigurations;
    };
}
