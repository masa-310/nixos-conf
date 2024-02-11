{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    dotfile-path = {
      url = "github:masa-310/dotfiles";
      flake = false;
    };
    xmonad-config.url = "github:masa-310/xmonad-conf";
  };
  outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, dotfile-path, xmonad-config, ... }: 
    let
      overlay = final: prev: { inherit xmonad-config; };
      overlays = [overlay];
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "electron-25.9.0" ];
      };
      pkgs = import nixpkgs { inherit system overlays config; } // { outPath = nixpkgs.outPath; };
      unstable = import nixpkgs-unstable { inherit system overlays config; } // { outPath = nixpkgs-unstable.outPath; };
      configurations = import ./hosts { inherit system config home-manager dotfile-path nixpkgs pkgs unstable; };
      nixosConfigurations = builtins.mapAttrs (_: conf: conf.nixosConfigurations) configurations;
      homeConfigurations = builtins.mapAttrs (_: conf: conf.homeConfigurations) configurations;
    in {
      inherit nixosConfigurations homeConfigurations;
    };
}
